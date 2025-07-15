--- @class Building : Body
--- @field mask table
local Building = class("Building", Body)


function Building:init(position, rotation, sprite, colliders)

    Body.init(self, position, rotation, sprite, DL_BUILDING)

    self.colliders = colliders or self:load_colliders(sprite.data.slices)
    self.bb = self:getBoundingBox()
    self.fixtures = {}
    self.ghost = true
    self.durability = DUR_BUILDING
    self.body:setActive(false)
    self.category = PC_BUILDING
    self.mask = {PC_PLAYER, PC_BEAM}
    self.sprite:set(self.sprite.animations.ghost)
    self.max = 0
end


function Building:clone()

    return self.class(self.position, self.rotation, self.sprite, self.colliders)
end


function Building:update(dt)

    self.sprite:update(dt)

    if self.ghost then return end
    
    self.position.x, self.position.y = self.body:getPosition()
    self.rotation = self.body:getAngle()
    
    if self.position.y <= -4 then
        audio.play(sound.sink.building, nil, 0.75 + math.random() * 0.75)
        self.body:destroy()
        self.parent:remove(self)
        ui.hint:queue("The ground seems unstable, buildings need support!")
        return
    end

    local fraction = self.dimpulse / (self.durability * self.body:getMass())
    local volume = math.min(fraction * fraction * 4, 1.0)
    audio.play(sound.hit.building, volume, math.random() * 0.25 + 0.25)

    if self.dimpulse > self.durability * self.body:getMass() then
        self.update = function(dt) self:destroy() end
        return
    end

    self.dimpulse = 0.0
end


function Building:draw()

    color.reset()
    local position = game.map:get_draw_position(self.position)
    -- local c = color.white
    -- local a = (self.ghost and 0.4) or 1
    self.sprite:draw(DL_BUILDING, position, -self.rotation, nil, nil, nil, nil)
end

--- Create collider bounding boxes from slices on a sprite
--- @param slices table
--- @return table
function Building:load_colliders(slices)

    local colliders = {}

    for i, slice in ipairs(slices) do

        local collider = {}
        collider.size = Vector(
            slice.keys[1].bounds.w / game.map.scale,
            slice.keys[1].bounds.h / game.map.scale
        )
        collider.min = Vector(
            (slice.keys[1].bounds.x - self.sprite.size.x / 2.0) / game.map.scale,
            (self.sprite.size.y / 2.0 - slice.keys[1].bounds.y - slice.keys[1].bounds.h) / game.map.scale
        )
        collider.center = Vector(
            collider.min.x + collider.size.x / 2.0,
            collider.min.y + collider.size.y / 2.0
        )
        collider.max = Vector(
            collider.min.x + collider.size.x,
            collider.min.y + collider.size.y
        )
        table.insert(colliders, collider)
    end

    return colliders
end

--- Generate bounding box from colliders bounding boxes
--- @return table 
function Building:getBoundingBox()

    local bb = {}
    bb.min = Vector()
    bb.max = Vector()

    for i, collider in ipairs(self.colliders) do
        
        bb.min.x = math.min(bb.min.x, collider.min.x)
        bb.min.y = math.min(bb.min.y, collider.min.y)
        bb.max.x = math.max(bb.max.x, collider.max.x)
        bb.max.y = math.max(bb.max.y, collider.max.y)
    end
    bb.size = Vector(bb.max.x - bb.min.x, bb.max.y - bb.min.y)
    bb.center = Vector(bb.min.x + bb.size.x / 2.0, bb.min.y + bb.size.y / 2.0)
    return bb
end

--- Materialize building from its ghost state at given position
--- @param position any
function Building:place(position)

    if position then self.body:setPosition(position.x, position.y) end

    for i, collider in ipairs(self.colliders) do
        local fixture = love.physics.newFixture(self.body, love.physics.newRectangleShape(collider.center.x, collider.center.y, collider.size.x, collider.size.y), DS_BUILDING)
        fixture:setCategory(self.category)
        fixture:setMask(unpack(self.mask))
        table.insert(self.fixtures, fixture)
    end
    self.ghost = false
    self.sprite:set(self.sprite.animations.idle)
    self.sprite.animation:play()
    self.body:setActive(true)
end


function Building:make_gib(position, rotation, velocity)

    local gib = Gib(position, rotation)
    game.map:add(gib)
    gib:place()
    gib.body:setLinearVelocity(velocity.x, velocity.y)
end

function Building:destroy(position)

    audio.play(sound.destroy.building, nil, 0.75 + math.random() * 0.75)
    self.body:destroy()
    self:make_gib(self.position:getCopy(), math.random(), Vector((math.random() - 0.5) * GIB_SPEED, (math.random() - 0.5) * GIB_SPEED))
    self:make_gib(self.position:getCopy(), math.random(), Vector((math.random() - 0.5) * GIB_SPEED, (math.random() - 0.5) * GIB_SPEED))
    self:make_gib(self.position:getCopy(), math.random(), Vector((math.random() - 0.5) * GIB_SPEED, (math.random() - 0.5) * GIB_SPEED))
    self:make_gib(self.position:getCopy(), math.random(), Vector((math.random() - 0.5) * GIB_SPEED, (math.random() - 0.5) * GIB_SPEED))
    self:make_gib(self.position:getCopy(), math.random(), Vector((math.random() - 0.5) * GIB_SPEED, (math.random() - 0.5) * GIB_SPEED))
    self.parent:remove(self)
end


function Building:begincontact(a, b, contact)

    -- print(a:getBody():getLinearVelocity())
    -- if sql(a:getBody():getLinearVelocity()) > 0.1 then
    --     audio.play(sound.hit, nil, math.random() * 0.5 + 0.5)
    -- end
end


function Building:presolve(a, b, contact)

end


function Building:postsolve(a, b, contact, normalimpulse, tangentimpulse)

    -- local fraction = normalimpulse / self.durability
    -- local volume = math.min(fraction * fraction * 8, 1.0)
    -- if not sound.hit:isPlaying() or volume > sound.hit:getVolume() then
    --     audio.play(sound.hit, volume, math.random() * 0.25 + 0.5)
    -- end

    -- if self.rotation > math.pi / 2 or self.rotation < - math.pi / 2 then
    --     normalimpulse = normalimpulse * 4
    -- end 
    -- if contact.normal.y < 0.5 then
    --     normalimpulse = normalimpulse * 4
    -- end
    local impulse = normalimpulse[1] + normalimpulse[2] + math.abs(tangentimpulse[1] + tangentimpulse[2])
    self.dimpulse = math.max(self.dimpulse, impulse)

    -- if b:getCategory() == PC_GROUND then
    --     ui.hint:queue("The ground seems unstable, buildings need support!")
    --     self.update = function(dt) self:destroy(contact.position) end
    --     return
    -- end
    -- if (normalimpulse > self.max) then
    --     self.max = normalimpulse;
    -- end
    -- print(self.max)
end


function Building:set_position(position)

    self.position = position
    self.body:setPosition(self.position.x, self.position.y)
end


return Building
