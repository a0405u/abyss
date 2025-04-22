local Map = class("Map", Object)

--- @class Map
--- @field tilemap Tilemap
function Map:init()

    Object.init(self)
    self.position = {
        x = 0.0,
        y = 0.0
    }
    self.scale = 4
    self.size = {
        x = screen.size.x / self.scale,
        y = screen.size.y / self.scale
    }
    self.objects = {}
    self.ground = {
        height = 2
    }
    self.tilemap = Tilemap(Vector(0, self.ground.height), Vector(64, 64))
    self.body = love.physics.newBody(game.world, self.size.x / 2, self.size.y / 2, "static")
    self.fixture = love.physics.newFixture(self.body, love.physics.newRectangleShape(0, - self.size.y / 2 + self.ground.height / 2, self.size.x, self.ground.height))
    self.fixture:setCategory(PC_GROUND)
    self.left_fixture = love.physics.newFixture(self.body, love.physics.newRectangleShape(-self.size.x, 0, self.size.x, self.size.y))
    self.right_fixture = love.physics.newFixture(self.body, love.physics.newRectangleShape(self.size.x, 0, self.size.x, self.size.y))
    self.background = Drawable(Vector(54, 48), sprites.background, DL_BACKGROUND)
end


function Map:update(dt)

    Object.update(self, dt)
    self.tilemap:update(dt)
end


function Map:draw()

    local position = self:get_draw_position(Vector(self.size.x, self.ground.height))
    color.set(color.darkest)
    love.graphics.line(0, position.y, position.x, position.y)
    color.reset()
    self.background:draw()
    Object.draw(self)
    self.tilemap:draw()
end


function Map:is_in_bounds(x, y)

    return x >= 0 and x < self.size.x and y >= 0 and y < self.size.y
end


function Map:get_scaled_vector(vector)

    return Vector(vector.x * self.scale, vector.y * self.scale)
end

--- @param position Vector
function Map:get_draw_position(position)

    return Vector(self.position.x + position.x * self.scale, self.position.y + (self.size.y - position.y) * self.scale)
end


--- @param position Vector
function Map:get_position(position)

    return Vector((position.x - self.position.x) / self.scale, self.size.y - (position.y - self.position.y) / self.scale)
end


--- @param position Vector
function Map:get_objects_of_class(position, class)

    local objects = {}

    game.world:queryBoundingBox(position.x - 1, position.y - 1, position.x + 1, position.y + 1, function(fixture)

        if fixture:testPoint(position.x, position.y) then
            local object = fixture:getBody():getUserData()
            if object and object:is(class) then table.insert(objects, object) end
        end
        return true
    end)
    return objects
end


--- @param position Vector
function Map:get_objects(position)

        local objects = {}

        game.world:queryBoundingBox(position.x - 1, position.y - 1, position.x + 1, position.y + 1, function(fixture)

            if fixture:testPoint(position.x, position.y) then
                local object = fixture:getBody():getUserData()
                if object then table.insert(objects, object) end
            end
            return true
        end)
        return objects
end


--- @param position Vector
--- @param size number 
function Map:get_objects_in_box(position, size)

    size = size or 2
    local objects = {}

    game.world:queryBoundingBox(position.x - size / 2, position.y - size / 2, position.x + size / 2, position.y + size / 2, function(fixture)

        if fixture:testPoint(position.x, position.y) then
            local object = fixture:getBody():getUserData()
            if object then table.insert(objects, object) end
        end
        return true
    end)
    return objects
end


--- @param position Vector
function Map:get_fixtures(position)

    local fixtures = {}

    game.world:queryBoundingBox(position.x - 1, position.y - 1, position.x + 1, position.y + 1, function(fixture)

        if fixture:testPoint(position.x, position.y) then
            table.insert(fixtures, fixture)
        end
        return true
    end)
    return fixtures
end


--- @param position Vector
--- @param size number 
function Map:get_fixtures_in_box(position, size)

    size = size or 2
    local fixtures = {}

    game.world:queryBoundingBox(position.x - size / 2, position.y - size / 2, position.x + size / 2, position.y + size / 2, function(fixture)

        table.insert(fixtures, fixture)
        return true
    end)
    return fixtures
end


return Map