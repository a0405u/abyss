--- @class Building: Object
local Building = class("Building", Object)


function Building:init(position, rotation, sprite, colliders)

    self.position = position or Vector2()
    self.rotation = rotation or 0.0
    self.sprite = sprite:instantiate() or sprites.building:instantiate()
    self.colliders = colliders or sprite.data.slices
    self.ghost = true
    self.strength = BUILDING_STRENGTH
    self.body = love.physics.newBody(game.world, self.position.x, self.position.y, "dynamic")
    self.body:setUserData(self)
    self.body:setActive(false)
    self.sprite:set(self.sprite.animations.ghost)
end


function Building:make_gib(position, rotation, velocity)

    local gib = Gib(position, rotation)
    game.map:add(gib)
    gib:place()
    gib.body:setLinearVelocity(velocity.x, velocity.y)
end

function Building:destroy(position)

    self.body:destroy()
    self:make_gib(self.position:clone(), math.random(), Vector2((math.random() - 0.5) * GIB_SPEED, (math.random() - 0.5) * GIB_SPEED))
    self:make_gib(self.position:clone(), math.random(), Vector2((math.random() - 0.5) * GIB_SPEED, (math.random() - 0.5) * GIB_SPEED))
    self:make_gib(self.position:clone(), math.random(), Vector2((math.random() - 0.5) * GIB_SPEED, (math.random() - 0.5) * GIB_SPEED))
    self:make_gib(self.position:clone(), math.random(), Vector2((math.random() - 0.5) * GIB_SPEED, (math.random() - 0.5) * GIB_SPEED))
    self:make_gib(self.position:clone(), math.random(), Vector2((math.random() - 0.5) * GIB_SPEED, (math.random() - 0.5) * GIB_SPEED))
    self.parent:remove(self)
end


function Building:postsolve(a, b, contact, normalimpulse, tangentimpulse)

    if self.rotation > math.pi / 2 or self.rotation < - math.pi / 2 then
        normalimpulse = normalimpulse * 4
    end 
    if b:getCategory() == PC_GROUND or b:getCategory() == PC_BUILDING or normalimpulse > self.strength then
        self.update = function(dt) self:destroy(Vector2(contact.position)) end
    end
end


function Building:set_position(position)

    self.position = position
    self.body:setPosition(self.position.x, self.position.y)
end


function Building:place(position)

    if position then self.body:setPosition(position.x, position.y) end

    for i, collider in ipairs(self.colliders) do
        local w = collider.keys[1].bounds.w / game.map.scale
        local h = collider.keys[1].bounds.h / game.map.scale
        self.fixture = love.physics.newFixture(self.body, love.physics.newRectangleShape(0, h / 2, w, h), DS_BUILDING)
        self.fixture:setCategory(PC_BUILDING)
        self.fixture:setMask(PC_PLAYER)
    end
    self.ghost = false
    self.sprite:set(self.sprite.animations.idle)
    self.body:setActive(true)
end


function Building:update(dt)

    if self.ghost then
        return
    end
    self.position.x, self.position.y = self.body:getPosition()
    self.rotation = self.body:getAngle()
end


function Building:draw()

    color.reset()
    local position = game.map:get_draw_position(self.position)
    -- local c = color.white
    -- local a = (self.ghost and 0.4) or 1
    self.sprite:draw(DL_BUILDING, position, -self.rotation, nil, nil, c, a)
end


return Building
