local Map = class("Map", Object)

--- @class Map
function Map:init()

    Object.init(self)
    self.position = {
        x = 0.0,
        y = 0.0
    }
    self.scale = 4
    self.size = {
        x = screen.width / self.scale,
        y = screen.height / self.scale
    }
    self.objects = {}
    self.ground = {
        height = 2
    }
    self.body = love.physics.newBody(game.world, self.size.x / 2, self.ground.height / 2, "static")
    self.fixture = love.physics.newFixture(self.body, love.physics.newRectangleShape(self.size.x, self.ground.height))
end


function Map:update(dt)

    Object.update(self, dt)
end


function Map:draw()

    local position = self:get_draw_position(Vector2(self.size.x, self.ground.height))
    color.set(color.darkest)
    love.graphics.line(0, position.y, position.x, position.y)
    color.reset()
    Object.draw(self)
end


function Map:is_in_bounds(x, y)

    return x >= 0 and x < self.size.x and y >= 0 and y < self.size.y
end


function Map:get_scaled_vector(vector)

    return Vector2(vector.x * self.scale, vector.y * self.scale)
end

--- @param position Vector2
function Map:get_draw_position(position)

    return Vector2(self.position.x + position.x * self.scale, self.position.y + (self.size.y - position.y) * self.scale)
end


--- @param position Vector2
function Map:get_position(position)

    return Vector2((position.x - self.position.x) / self.scale, self.size.y - (position.y - self.position.y) / self.scale)
end


return Map