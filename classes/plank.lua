--- @class Plank : Body
--- @field position Vector
local Plank = class("Plank", Body)

---@class PlankType
local PlankType = {
    platform = {
        category = PC_PLATFORM,
        color = color.dark,
        mask = {PC_BACKGROUND},
        dl = DL_PLATFORM,
        animation = "platform",
    },
    wall = {
        category = PC_WALL,
        color = color.dark,
        mask = {PC_BACKGROUND},
        dl = DL_WALL,
        animation = "wall",
    },
	beam = {
        category = PC_BEAM,
        color = color.darkest,
        mask = {PC_PLAYER, PC_BUILDING, PC_BACKGROUND},
        dl = DL_BEAM,
        animation = "beam",
    },
	gib = {
        category = PC_GIB,
        color = color.purple,
        mask = {PC_BACKGROUND},
        dl = DL_GIB,
        durability = DUR_PLANK / 4,
        animation = "gib",
    },
	ghost = {
        category = PC_GHOST,
        color = color.purple,
        dl = DL_GHOST,
        group = 12,
        mask = PC_PLANK,
        filter = {1, 0, 0},
        density = 1,
        animation = "ghost",
    }
}

Plank.Type = PlankType

--- @param position Vector | nil
---@param rotation number | nil
---@param length number | nil
---@param mass number | nil
function Plank:init(position, rotation, length, mass)

    Body.init(self, position, rotation, sprites.plank, DL_GHOST)

    self.type = PlankType.ghost
    self.sprite:set(self.sprite.animations.ghost)
    self.length = length or 2
    self.sprite.scale = Vector(self.length / 5, 1)
    self.width = 0.75
    self.min_length = LN_PLANK_MIN
    self.max_length = LN_PLANK_MAX
    self.point = Vector(
        math.cos(self.rotation) * self.length + self.position.x, 
        math.sin(self.rotation) * self.length + self.position.y)
    self.velocity = Vector()
    self.durability = DUR_PLANK
    self.mass = mass or self.length * 5
    self.ghost = true
    self.frozen = false

    -- self.body:setSleepingAllowed(false)

    self.fixture = love.physics.newFixture(self.body, love.physics.newRectangleShape(self.length / 2, 0, self.length, self.width), DS_PLANK)
    self.fixture:setCategory(PC_PLANK)
    
    self:set_type(PlankType.ghost)
    self.nails = {}
    self.timer = Timer()
    self.visible = true
end


function Plank:update(dt)
    Body.update(self, dt)
    
    self.point = Vector(
        math.cos(self.rotation) * self.length + self.position.x, 
        math.sin(self.rotation) * self.length + self.position.y)
    self.timer:update(dt)

    if self.position.y <= -4 then
        audio.play(sound.sink.plank, nil, 0.75 + math.random() * 0.75)
        self.body:destroy()
        for key, nail in pairs(self.nails) do
            nail:destroy()
        end
        self.parent:remove(self)
        ui.hint:queue("The ground seems unstable, planks need support!")
        return
    end

    self:collision_sound(sound.hit.plank, math.random() * 0.25 + 0.75)

    if self.dimpulse > self.durability * self.body:getMass() then
        self.update = function(dt) self:destroy() end
    end

    self.dimpulse = 0.0
end


function Plank:draw()

    if not self.visible then return end
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


function Plank:activate(frozen)

    self:set_frozen(frozen)
    self.fixture:destroy()
    self.fixture = love.physics.newFixture(self.body, love.physics.newRectangleShape(self.length / 2, 0, self.length, self.width), DS_PLANK)
    self.fixture:setCategory(PC_PLANK)
    self.ghost = false
    self.body:setActive(true)

    -- if (math.abs(self.rotation) > math.pi / 6 and math.abs(self.rotation) < 5 * math.pi / 6) then
    --     self:set_type(PlankType.beam, self.sprite.animations.beam)
    -- else
    --     self:set_type(PlankType.platform, self.sprite.animations.platform)
    -- end
    self.timer:start(3, function() self:set_frozen(false) end)
    return true
end


function Plank:make_gib(position, rotation, length, velocity)
    local gib = Plank(position, rotation, length, velocity)
    gib:activate()
    gib:set_frozen(false)
    gib:set_type(PlankType.gib, gib.sprite.animations.gib)
    gib.body:setLinearVelocity(velocity:get())
    self.parent:add(gib)
    return gib
end


function Plank:destroy()

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
    audio.play(sound.destroy.plank, 0.5, 0.75 + math.random() * 0.75)
end


function Plank:endcontact(a, b, contact)

    if self.frozen then
        self:set_frozen(false)
    end
end


function Plank:presolve(a, b, contact)

    Body.presolve(self, a, b, contact)
    
    if b:getCategory() == PC_PLAYER then
        local x, y = contact:getPositions()
        local nx, ny = contact:getNormal()
        local c1, c2 = self.fixture:getCategory()
        if (c2 == PC_PLATFORM and (ny > -0.5 or game.player.down)) or c2 == PC_BEAM then
            contact:setEnabled(false)
            return true
        end
    end

    if self.frozen then -- and b:getCategory() ~= PC_PLANK then
        self:set_frozen(false)
    end
end


function Plank:is_nailed()

    for key, nail in pairs(self.nails) do
        return true
    end
    return false
end


function Plank:set_type(type)

    self.type = type
    self.fixture:setCategory(PC_PLANK, type.category)
    if type.mask then self.fixture:setMask(type.mask) else self.fixture:setMask() end
    if type.animation then self.sprite:set(self.sprite.animations[type.animation]) end
    self.durability = type.durability or DUR_PLANK
    self.fixture:setDensity(type.density or DS_PLANK)
    self.body:resetMassData()
    self.fixture:setGroupIndex(type.group or 0)
    if type.filter then self.fixture:setFilterData(type.filter[1], type.filter[2], type.filter[3]) end
end


function Plank:set_frozen(frozen)

    self.frozen = frozen or false
    if self.frozen then
        self.body:setLinearVelocity(0, 0)
        self.body:setAngularVelocity(0)
        self.timer:stop()
    end
    self.body:setFixedRotation(self.frozen)
    self.body:setAwake(not self.frozen)
end


function Plank:add_nail(position)

    if (game.map.ground.fixture:testPoint(position.x, position.y)) then
        -- game.map:add(Nail(Vector(position.x, position.y), game.map, self))
        return
    else
        local fixtures = game.map:get_fixtures(position)

        for i, fixture in ipairs(fixtures) do
            if fixture == self.fixture then goto continue end
            local category = {fixture:getCategory()}
            if category[1] == PC_PLANK or category[1] == PC_BLOCK then
                local object = fixture:getBody():getUserData()
                if object:is(BuildingSoil) then
                    game.map:add(Nail(Vector(position.x, position.y), object, self))
                else
                    game.map:add(Nail(Vector(position.x, position.y), object, self, false))
                end
                goto continue
            end
            if category[1] == PC_TILE and fixture:getBody():getUserData().solid then
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
    self.point = Vector(
        math.cos(self.rotation) * self.length + self.position.x,
        math.sin(self.rotation) * self.length + self.position.y)
end


function Plank:set_angle(angle)

    self.rotation = angle
    self.body:setAngle(self.rotation)
end


return Plank
