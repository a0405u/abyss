--- @class Plank
local Plank = class("Plank", Object)


function Plank:init(position, rotation, length, mass)

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
    self.mass = mass or 5
    self.ghost = true
    self.body = love.physics.newBody(game.world, self.position.x, self.position.y, "dynamic")
    self.body:setAngle(self.rotation)
    self.body:setActive(false)
end


function Plank:unfreeze()

    self.fixture = love.physics.newFixture(self.body, love.physics.newRectangleShape(self.length / 2, 0, self.length, self.width))
    self.fixture:setCategory(PC_PLANKS)
    self.ghost = false
    self.body:setActive(true)

    if (game.map.fixture:testPoint(self.position.x, self.position.y)) then
        game.map:add(Nail(Vector2(self.position.x, self.position.y), game.map.body, self.body))
    end

    if (game.map.fixture:testPoint(self.point.x, self.point.y)) then
        game.map:add(Nail(Vector2(self.point.x, self.point.y), game.map.body, self.body))
    end

    game.world:queryBoundingBox(self.position.x - 1, self.position.y - 1, self.position.x + 1, self.position.y + 1, function(fixture)
    
        if fixture == self.fixture then return true end
        if fixture:testPoint(self.position.x, self.position.y) and fixture:getCategory() == PC_PLANKS then
            game.map:add(Nail(Vector2(self.position.x, self.position.y), fixture:getBody(), self.body, true))
        end
        return true
    end)

    game.world:queryBoundingBox(self.point.x - 1, self.point.y - 1, self.point.x + 1, self.point.y + 1, function(fixture)
    
        if fixture == self.fixture then return true end
        if fixture:testPoint(self.point.x, self.point.y) and fixture:getCategory() == PC_PLANKS then
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
end


function Plank:draw()

    local origin = game.map:get_draw_position(self.position)
    local point = game.map:get_draw_position(self.point)
    color.set(color.dark)
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
