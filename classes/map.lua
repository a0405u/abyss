--- @class Map : Object
--- @field tilemap Tilemap
local Map = class("Map", Object)

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
    self.body = love.physics.newBody(game.world)

    self.ground = Body(Vector(self.size.x / 2, 0), 0.0, sprites.ground, DL_GROUND, "static")
    self.ground.height = 2.0
    self.ground.sprite.offset.y = self.ground.sprite.size.y / 2 + self.ground.height * self.scale
    self.ground.fixture = love.physics.newFixture(self.ground.body, love.physics.newRectangleShape(0, 0, self.size.x, self.ground.height * 2))
    self.left_fixture = love.physics.newFixture(self.ground.body, love.physics.newRectangleShape(-self.size.x, self.size.y / 2, self.size.x, self.size.y))
    self.right_fixture = love.physics.newFixture(self.ground.body, love.physics.newRectangleShape(self.size.x, self.size.y / 2, self.size.x, self.size.y))
    self.ground.fixture:setCategory(PC_GROUND)
    -- self.fixture:setRestitution(RST_GROUND)

    function self.ground:presolve(a, b, contact)
        
        if b:getCategory() == PC_PLAYER or b:getCategory() == PC_BLOCK then return end

        local body = b:getBody()
        local x, y = contact:getPositions()
        -- contact:setRestitution(RST_GROUND)
        -- body:applyForce(0, - SAND_FORCE * body:getMass())

        contact:setEnabled(false)
        local depth = 2 - y
        body:applyLinearImpulse(0, SAND_FORCE * body:getMass() * y * 0.002, x, y)
        body:setAngularVelocity(body:getAngularVelocity() * (y / 2))
    end

    self.background = Drawable(Vector(64, 48), 0.0, sprites.background, DL_BACKGROUND)

    self.tilemap = Tilemap(Vector(0, self.ground.height), Vector(64, 64))
end

function Map:update(dt)

    Object.update(self, dt)
    self.tilemap:update(dt)
    -- self.ground.timer:update(dt)
end


function Map:draw()

    local position = self:get_draw_position(Vector(self.size.x, self.ground.height))
    screen.layer:queue(DL_GROUND, function()
        color.set(color.black)
        love.graphics.rectangle("fill", 0, position.y, position.x, position.y)
        color.reset()
    end)
    -- screen.layer:queue(DL_BACKGROUND, function()
    --     color.set(color.darkest)
    --     love.graphics.line(0, position.y, position.x, position.y)
    --     color.reset()
    -- end)
    self.ground:draw()
    self.background:draw(nil, 0.5)
    Object.draw(self)
    self.tilemap:draw()
end


function Map:is_in_bounds(x, y)

    return x >= 0 and x < self.size.x and y >= 0 and y < self.size.y
end


function Map:get_scaled_vector(vector)

    return Vector(vector.x * self.scale, vector.y * self.scale)
end

--- Get Screen position from World position
--- @param position Vector
function Map:get_draw_position(position, camera_scale)

    return Vector(
        -- self.position.x + (position.x) * self.scale, 
        self.position.x + (position.x - game.camera.position.x * (camera_scale or 1)) * self.scale,
        self.position.y + (self.size.y - position.y + game.camera.position.y * (camera_scale or 1)) * self.scale
    )
end

--- Get World position from Screen position
--- @param position Vector
function Map:get_position(position)

    return Vector((position.x - self.position.x) / self.scale + game.camera.position.x, self.size.y - (position.y - self.position.y) / self.scale + game.camera.position.y)
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