--- @class Plank: Object
local Plank = class("Plank", Object)

---@class Type
local Type = {
    platform = {
        category = PC_PLATFORM,
        color = color.dark,
    },
	column = {
        category = PC_COLUMN,
        color = color.darkest,
        mask = PC_PLAYER
    }
}

function Plank:init(position, rotation, length, mass)

    self.type = Type.column
    self.position = position or Vector2()
    self.rotation = rotation or 0.0
    self.length = length or 2
    self.width = 0.75
    self.max_length = 8
    self.point = Vector2(
        math.cos(self.rotation) / self.length + self.position.x, 
        math.sin(self.rotation) / self.length + self.position.y)
    self.velocity = Vector2()
    self.strength = 120
    self.mass = mass or self.length * 5
    self.ghost = true
    self.body = love.physics.newBody(game.world, self.position.x, self.position.y, "dynamic")
    self.body:setUserData(self)
    self.body:setAngle(self.rotation)
    self.body:setActive(false)
end


function Plank:make_gib(position, rotation, length)
    local gib = Plank(position, rotation, length)
    gib:unfreeze()
    self.parent:add(gib)
end


function Plank:destroy(point)

    self.body:destroy()
    if self.length > 2 then
        self:make_gib(self.position:clone(), self.rotation, self.length / 2)
        self:make_gib(self.point:clone(), math.pi + self.rotation, self.length / 2)
    end
    self.parent:remove(self)
end


function Plank:presolve(a, b, contact)

    local x, y = contact:getPositions()
    local nx, ny = contact:getNormal()
    local c1, c2 = a:getCategory()
    if ny > -0.5 or c2 == PC_COLUMN then
        contact:setEnabled(false)
        return true
    end
end


function Plank:postsolve(a, b, contact, normalimpulse, tangentimpulse)

    if normalimpulse > self.strength then
        self.update = function(dt) self:destroy(Vector2(contact:getPositions())) end
    end
end

function Plank:set_type(type)

    print(type, type.category, type.color)
    self.type = type
    self.fixture:setCategory(PC_PLANK, type.category)
    if type.mask then self.fixture:setMask(type.mask) end
end


function Plank:unfreeze()

    self.fixture = love.physics.newFixture(self.body, love.physics.newRectangleShape(self.length / 2, 0, self.length, self.width))
    self.fixture:setCategory(PC_PLANK)
    self.ghost = false
    self.body:setActive(true)

    if (math.abs(self.rotation) > math.pi / 3 and math.abs(self.rotation) < 2 * math.pi / 3) then
        self:set_type(Type.column)
    else
        self:set_type(Type.platform)
    end

    if (game.map.fixture:testPoint(self.position.x, self.position.y)) then
        game.map:add(Nail(Vector2(self.position.x, self.position.y), game.map.body, self.body))
    end

    if (game.map.fixture:testPoint(self.point.x, self.point.y)) then
        game.map:add(Nail(Vector2(self.point.x, self.point.y), game.map.body, self.body))
    end

    game.world:queryBoundingBox(self.position.x - 1, self.position.y - 1, self.position.x + 1, self.position.y + 1, function(fixture)
    
        if fixture == self.fixture then return true end
        if fixture:testPoint(self.position.x, self.position.y) and fixture:getCategory() == PC_PLANK then
            game.map:add(Nail(Vector2(self.position.x, self.position.y), fixture:getBody(), self.body, true))
        end
        return true
    end)

    game.world:queryBoundingBox(self.point.x - 1, self.point.y - 1, self.point.x + 1, self.point.y + 1, function(fixture)
    
        if fixture == self.fixture then return true end
        if fixture:testPoint(self.point.x, self.point.y) and fixture:getCategory() == PC_PLANK then
            game.map:add(Nail(Vector2(self.point.x, self.point.y), fixture:getBody(), self.body, true))
        end
        return true
    end)
end


--- @param point Vector2
function Plank:set_point(point)
    local vector = Vector2(point.x - self.position.x, point.y - self.position.y)
    local length = vector:length()
    if length > self.max_length then
        local normal = vector:normalized()
        self.length = self.max_length
        normal:mult(self.length)
        normal:add(self.position)
        self.point = normal
    else
        self.length = length
        self.point = point
    end
    self.rotation = math.atan2(vector.y, vector.x)
    self.body:setAngle(self.rotation)
end


function Plank:update(dt)

    if self.ghost then
        return
    end
    self.position.x, self.position.y = self.body:getPosition()
    self.rotation = self.body:getAngle()
    
    self.point = Vector2(
        math.cos(self.rotation) * self.length + self.position.x, 
        math.sin(self.rotation) * self.length + self.position.y)

    local contacts = self.body:getContacts()

    for i, contact in ipairs(contacts) do

        local x, y = contact:getPositions()
        local nx, ny = contact:getNormal()
        if ny > 0.5 and self.position.y > y then
            -- contact:setEnabled(false)
            return true
        end
    end
    return false
end


function Plank:draw()

    local origin = game.map:get_draw_position(self.position)
    local point = game.map:get_draw_position(self.point)
    color.set(self.type.color)
    love.graphics.setLineWidth(3)
    love.graphics.line(origin.x, origin.y, point.x, point.y)
    love.graphics.setLineWidth(1)
    color.reset()
    -- color.set(color.blue)
    -- if not self.ghost then
    --     local x1, y1, x2, y2, x3, y3, x4, y4 = self.body:getFixtures()[1]:getShape():getPoints()
    --     local v1 = game.map:get_draw_position(Vector2(self.position.x + x1, self.position.y + y1))
    --     local v2 = game.map:get_draw_position(Vector2(self.position.x + x2, self.position.y + y2))
    --     local v3 = game.map:get_draw_position(Vector2(self.position.x + x3, self.position.y + y3))
    --     local v4 = game.map:get_draw_position(Vector2(self.position.x + x4, self.position.y + y4))
    --     love.graphics.polygon("line", v1.x, v1.y, v2.x, v2.y, v3.x, v3.y, v4.x, v4.y)
    -- end
end


return Plank
