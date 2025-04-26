--- @class Tile
local Tile = class("Tile", Object)


function Tile:init(sprite, size)

    self.map = nil
    self.position = Vector()
    self.sprite = sprite or sprites.tile
    self.size = size or Vector(TILESIZE, TILESIZE)
    self.body = love.physics.newBody(game.world, 0, 0, "static")
    self.fixture = love.physics.newFixture(self.body, love.physics.newRectangleShape(self.size.x, self.size.y))
    self.fixture:setCategory(PC_BLOCK)
    self.body:setUserData(self)
    self.cost = COST_BLOCK
    self.dl = nil
    self.indestructible = nil
    self.support = true
    self.solid = true
end


function Tile:instantiate()

    return Tile(self.sprite, self.size)
end


function Tile:place(map, position)

    self.map = map
    self.position = position
    local world_position = self.map:get_world_position(self.position)
    self.body:setPosition(world_position.x, world_position.y)
end


function Tile:update(dt)
    
end


function Tile:is_stable()

    if self.position.y == 1 then return true end
    local tile = self.map.tile[self.position.x][self.position.y - 1]
    if tile and tile.support then
        return true
    end
    return false
end


function Tile:draw(position)

    position = position or self.map:get_draw_position(self.position)
    self.sprite:draw(self.dl or DL_TILE, position)
end

function Tile:make_gib(position, rotation, velocity)

    local gib = Gib(position, rotation)
    game.map:add(gib)
    gib:place()
    gib.body:setLinearVelocity(velocity.x, velocity.y)
end

function Tile:destroy(position)

    audio.play(sound.destroy, 0.75 + math.random() * 0.75)
    local joints = self.body:getJoints()
    for i, joint in ipairs(joints) do
        local nail = joint:getUserData()
        nail:destroy()
    end
    self.body:destroy()
    self:make_gib(self.map:get_world_position(self.position), math.random(), Vector((math.random() - 0.5) * GIB_SPEED, (math.random() - 0.5) * GIB_SPEED))
    self:make_gib(self.map:get_world_position(self.position), math.random(), Vector((math.random() - 0.5) * GIB_SPEED, (math.random() - 0.5) * GIB_SPEED))
    self:make_gib(self.map:get_world_position(self.position), math.random(), Vector((math.random() - 0.5) * GIB_SPEED, (math.random() - 0.5) * GIB_SPEED))
    self:make_gib(self.map:get_world_position(self.position), math.random(), Vector((math.random() - 0.5) * GIB_SPEED, (math.random() - 0.5) * GIB_SPEED))
    self:make_gib(self.map:get_world_position(self.position), math.random(), Vector((math.random() - 0.5) * GIB_SPEED, (math.random() - 0.5) * GIB_SPEED))
    self.map.tile[self.position.x][self.position.y] = nil
end

function Tile:remove()
    self.body:destroy()
    self = nil
end

return Tile
