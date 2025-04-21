--- @class Plank: Object
local Plank = class("Plank", Object)

---@class Type
local Type = {
    platform = {
        category = PC_PLATFORM,
        color = color.dark,
        dl = DL_PLATFORM
    },
	column = {
        category = PC_COLUMN,
        color = color.darkest,
        mask = {PC_PLAYER, PC_BUILDING},
        dl = DL_COLUMN
    },
	gib = {
        category = PC_GIB,
        color = color.purple,
        -- mask = PC_GIB,
        dl = DL_GIB,
        strength = PLANK_STRENGTH / 4
    },
	ghost = {
        category = PC_GHOST,
        color = color.purple,
        dl = DL_GHOST,
        group = 12,
        mask = PC_PLANK,
        filter = {1, 0, 0},
        density = 1,
    }
}


function Plank:init(position, rotation, length, mass)

    self.type = Type.ghost
    self.sprite = sprites.plank:instantiate()
    self.sprite:set(self.sprite.animations.ghost)
    self.position = position or Vector()
    self.rotation = rotation or 0.0
    self.length = length or 2
    self.sprite.scale = Vector(self.length / 5, 1)
    self.width = 0.75
    self.min_length = LN_PLANK_MIN
    self.max_length = LN_PLANK_MAX
    self.point = Vector(
        math.cos(self.rotation) * self.length + self.position.x, 
        math.sin(self.rotation) * self.length + self.position.y)
    self.velocity = Vector()
    self.strength = PLANK_STRENGTH
    self.mass = mass or self.length * 5
    self.ghost = true
    -- self.frozen = true
    self.body = love.physics.newBody(game.world, self.position.x, self.position.y, "dynamic")
    self.body:setUserData(self)
    self.body:setAngle(self.rotation)
    -- self.body:setFixedRotation(true)
    -- self.body:setActive(false)
    -- self.body:setSleepingAllowed(false)
    self.fixture = love.physics.newFixture(self.body, love.physics.newRectangleShape(self.length / 2, 0, self.length, self.width), DS_PLANK)
    self.fixture:setCategory(PC_PLANK)
    self:set_type(Type.ghost, self.sprite.animations.ghost)
    self.nails = {}
    self.nailed = false
    self.timer = Timer()
end


function Plank:place()
    if self:activate() then
        self:add_nail(self.point)
        self:add_nail(self.position)
    end
end


function Plank:activate()

    self.body:setLinearVelocity(0, 0)
    self.body:setAngularVelocity(0)
    self.fixture:destroy()
    self.fixture = love.physics.newFixture(self.body, love.physics.newRectangleShape(self.length / 2, 0, self.length, self.width), DS_PLANK)
    self.fixture:setCategory(PC_PLANK)
    self.ghost = false
    self.body:setActive(true)

    if (math.abs(self.rotation) > math.pi / 6 and math.abs(self.rotation) < 5 * math.pi / 6) then
        self:set_type(Type.column, self.sprite.animations.column)
    else
        self:set_type(Type.platform, self.sprite.animations.platform)
    end
    self.timer:start(3, function() self:unfreeze() end)
    return true
end


function Plank:make_gib(position, rotation, length, velocity)
    local gib = Plank(position, rotation, length, velocity)
    gib:activate()
    gib:unfreeze()
    gib:set_type(Type.gib, gib.sprite.animations.gib)
    gib.frozen = false
    gib.body:setFixedRotation(false)
    gib.body:setAwake(true)
    gib.body:setLinearVelocity(velocity:get())
    self.parent:add(gib)
    return gib
end


function Plank:destroy(point, impulse)

    local gibs = {}
    if self.length > 2 then
        gibs[1] = self:make_gib(self.position:getCopy(), self.rotation, self.length / 2, Vector(self.body:getLinearVelocity()))
        gibs[2] = self:make_gib(self.point:getCopy(), math.pi + self.rotation, self.length / 2, Vector(self.body:getLinearVelocity()))
    end
    self.body:destroy()
    for key, nail in pairs(self.nails) do
        for i, gib in ipairs(gibs) do
            if gib.fixture:testPoint(nail.position:get()) then
                gib:add_nail(nail.position)
            end
        end
        nail:destroy()
    end
    self.parent:remove(self)
    audio.play(sound.destroy, 0.75 + math.random() * 0.75)
end


function Plank:endcontact(a, b, contact)

    if self.frozen then
        self:unfreeze()
    end
end


function Plank:presolve(a, b, contact)

    if b:getCategory() == PC_PLAYER then
        local x, y = contact:getPositions()
        local nx, ny = contact:getNormal()
        local c1, c2 = self.fixture:getCategory()
        if ny > -0.5 or c2 == PC_COLUMN then
            contact:setEnabled(false)
            return true
        end
    end
end


function Plank:postsolve(a, b, contact, normalimpulse, tangentimpulse)
    if self.frozen and (b:getCategory() ~= PC_PLANK or not self.nailed) then
        self:unfreeze()
    end
    if normalimpulse > self.strength then
        self.update = function(dt) self:destroy(contact.position, normalimpulse) end
    end
end

function Plank:set_type(type, animation)

    self.type = type
    self.fixture:setCategory(PC_PLANK, type.category)
    if type.mask then self.fixture:setMask(type.mask) else self.fixture:setMask() end
    if animation then self.sprite:set(animation) end
    self.strength = type.strength or PLANK_STRENGTH
    self.fixture:setDensity(type.density or DS_PLANK)
    self.body:resetMassData()
    self.fixture:setGroupIndex(type.group or 0)
    if type.filter then self.fixture:setFilterData(type.filter[1], type.filter[2], type.filter[3]) end
end


function Plank:unfreeze()

    self.frozen = false
    self.body:setFixedRotation(false)
    self.body:setAwake(true)
end


function Plank:add_nail(position)

    if (game.map.fixture:testPoint(position.x, position.y)) then
        -- game.map:add(Nail(Vector(position.x, position.y), game.map, self))
        return
    else
        local fixtures = game.map:get_fixtures(position)

        for i, fixture in ipairs(fixtures) do
            if fixture == self.fixture then goto continue end
            if fixture:getCategory() == PC_PLANK then
                game.map:add(Nail(Vector(position.x, position.y), fixture:getBody():getUserData(), self, false))
                goto continue
            end
            if fixture:getCategory() == PC_BLOCK then
                game.map:add(Nail(Vector(position.x, position.y), fixture:getBody():getUserData(), self))
                goto continue
            end
            ::continue::
        end
    end
end


function Plank:set_length(length)
    
    length = math.clamp(length, self.min_length, self.max_length)
    self.length = length
    self.sprite.scale = Vector(self.length / 5, 1)
end


function Plank:set_angle(angle)

    self.rotation = angle
    self.body:setAngle(self.rotation)
end


function Plank:update(dt)

    if self.ghost then
        -- return
    end
    self.position.x, self.position.y = self.body:getPosition()
    self.rotation = self.body:getAngle()
    
    self.point = Vector(
        math.cos(self.rotation) * self.length + self.position.x, 
        math.sin(self.rotation) * self.length + self.position.y)
    self.timer:update(dt)
end


function Plank:draw()

    color.reset()
    local origin = game.map:get_draw_position(self.position)
    -- local point = game.map:get_draw_position(self.point)
    self.sprite:draw(self.type.dl, origin, -self.rotation, Vector(self.sprite.scale.x, sign(math.cos(self.rotation))))
    -- color.set(self.type.color)
    -- love.graphics.setLineWidth(3)
    -- love.graphics.line(origin.x, origin.y, point.x, point.y)
    -- love.graphics.setLineWidth(1)
    -- color.reset()
    -- color.set(color.blue)
    -- if not self.ghost then
    --     local x1, y1, x2, y2, x3, y3, x4, y4 = self.body:getFixtures()[1]:getShape():getPoints()
    --     local v1 = game.map:get_draw_position(Vector(self.position.x + x1, self.position.y + y1))
    --     local v2 = game.map:get_draw_position(Vector(self.position.x + x2, self.position.y + y2))
    --     local v3 = game.map:get_draw_position(Vector(self.position.x + x3, self.position.y + y3))
    --     local v4 = game.map:get_draw_position(Vector(self.position.x + x4, self.position.y + y4))
    --     love.graphics.polygon("line", v1.x, v1.y, v2.x, v2.y, v3.x, v3.y, v4.x, v4.y)
    -- end
end


return Plank
