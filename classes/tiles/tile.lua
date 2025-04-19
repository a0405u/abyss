--- @class Tile
local Tile = class("Tile", Object)


function Tile:init(sprite, size)

    self.map = nil
    self.position = Vector2()
    self.sprite = sprite or sprites.tile
    self.size = size or Vector2(TILESIZE, TILESIZE)
    self.body = love.physics.newBody(game.world, 0, 0, "static")
    self.fixture = love.physics.newFixture(self.body, love.physics.newRectangleShape(self.size.x, self.size.y))
    self.fixture:setCategory(PC_BLOCK)
    self.body:setUserData(self)
    self.cost = COST_BLOCK
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


function Tile:draw(position)

    position = position or self.map:get_draw_position(self.position)
    self.sprite:draw(DL_TILE, position)
end


return Tile
