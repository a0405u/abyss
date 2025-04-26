--- @class Tilemap
local Tilemap = class("Tilemap", Object)


function Tilemap:init(position, size, tile_size)

    self.position = position or Vector()
    self.size = size or Vector(TILESIZE, TILESIZE)
    self.tile_size = tile_size or Vector(4, 4)
    self.tile = {}
    for x = 1, self.size.x do
        self.tile[x] = {}
    end
end


function Tilemap:line(block, position, count, indestructible)

    for i = 1, count do
        local tile = block:instantiate()
        self:place(tile, Vector(position.x + i - 1, position.y))
        tile.indestructible = indestructible
    end
end


function Tilemap:add_hill(position)

    local world_position = self:get_world_position(position)
    world_position.x = world_position.x - self.tile_size.x / 2
    world_position.y = world_position.y - self.tile_size.y / 2
    game.map:add(Drawable(world_position, sprites.hillbg, DL_HILL_BG))
    game.map:add(Drawable(world_position, sprites.hill, DL_HILL))

    self:line(Tile(), Vector(position.x + 8, 1), 11, true)
    self:line(Tile(), Vector(position.x + 9, 2), 10, true)
    self:line(Tile(), Vector(position.x + 10, 3), 8, true)
    self:line(Tile(), Vector(position.x + 12, 4), 6, true)
    self:line(Tile(), Vector(position.x + 12, 5), 5, true)
    self:line(Tile(), Vector(position.x + 12, 6), 5, true)
    self:line(Tile(), Vector(position.x + 13, 7), 3, true)
    self:line(Tile(), Vector(position.x + 14, 8), 2, true)
    self:place(Wheat(), Vector(position.x + 10, 4))
    self:place(Soil(), Vector(position.x + 10, 3), true)
    self:place(Soil(), Vector(position.x + 11, 3), true)
    self:place(Soil(), Vector(position.x + 17, 4), true)
    self:place(Soil(), Vector(position.x + 12, 6), true)
    self:place(Soil(), Vector(position.x + 14, 8), true)
    self:place(Soil(), Vector(position.x + 15, 8), true)
end


function Tilemap:is_present(position)

    if self.tile[position.x] then
        return self.tile[position.x][position.y]
    end
    return false
end


function Tilemap:is_in_tile(position, tile)

    local position_tile = self:get_position(position)
    return tile.x == position_tile.x and tile.y == position_tile.y
end


function Tilemap:check_any(position, rule)

    for dy = -1, 1 do
        for dx = -1, 1 do
            local condition = rule[dy + 2][dx + 2]
            local x, y = position.x + dx, position.y + dy
            local exists = self.tile[x][y] ~= nil
        
            if condition == 1 then
                if not exists then
                    return false
                else
                    return true
                end
            elseif condition == 0 and exists then
                return false
            end
      end
    end
    return true
end

function Tilemap:check(position, rule)

    for dy = -1, 1 do
        for dx = -1, 1 do
            local condition = rule[dy + 2][dx + 2]
            local x, y = position.x + dx, position.y + dy
            local exists = self.tile[x][y] ~= nil
        
            if condition == 1 and not exists then
                return false
            elseif condition == 0 and exists then
                return false
            end
      end
    end
    return true
end


function Tilemap:place(tile, position, indestructible)
    position = position or tile.position
    self.tile[position.x][position.y] = tile
    tile:place(self, position)
    tile.indestructible = indestructible

    local world_position = self:get_world_position(position)
    game.world:queryBoundingBox(world_position.x - self.tile_size.x / 2, world_position.y - self.tile_size.y / 2, world_position.x + self.tile_size.x / 2, world_position.y + self.tile_size.y / 2, function(fixture)
        if fixture == tile.fixture then return true end
        
        if fixture:getCategory() == PC_PLANK then
            local plank = fixture:getBody():getUserData()
            if self:is_in_tile(plank.position, position) then
                game.map:add(Nail(Vector(plank.position.x, plank.position.y), fixture:getBody():getUserData(), tile))
            end
            if self:is_in_tile(plank.point, position) then
                game.map:add(Nail(Vector(plank.point.x, plank.point.y), fixture:getBody():getUserData(), tile))
            end
            return true
        end

        if fixture:getCategory() == PC_BUILDING then
            local building = fixture:getBody():getUserData()
            building:destroy(world_position)
            return true
        end

        return true
    end)
end


function Tilemap:build(tile, position)

    if self:is_present(position) then
        local t = self.tile[position.x][position.y]
        if t:is(Wheat) or t:is(Tree) then
            t:destroy()
        else
            return false
        end
    end
    local tile_under = self.tile[position.x][position.y - 1]
    if tile:is(Wheat) or tile:is(Tree) then
        if tile_under and tile_under:is(Soil) then
            self:place(tile, position)
            return true
        end
        ui.hint:queue("It can grow only on Soil!")
        return false
    end
    if position.y == 1 or tile_under then
        local max = 1
        if tile:is(Block) then
            max = 3
        end
        if position.y <= max or (self:is_present(Vector(position.x - 1, position.y - max)) and self:is_present(Vector(position.x + 1, position.y - max))) then
            self:place(tile, position)
            return true
        end
        ui.hint:queue("There is not enough support!")
    end
    return false
end


function Tilemap:remove(position)

    local x, y = 0, 0
    local tile = self.tile[position.x][position.y]
    if not tile or tile.indestructible then return end
    tile:destroy()
    time:delay(function()
        self:check_stability(Vector(position.x, position.y + 1))
    end, 0.5)
    time:delay(function() 
        self:check_stability(Vector(position.x - 1, position.y + 1))
    end, 0.5)
    time:delay(function() 
        self:check_stability(Vector(position.x + 1, position.y + 1))
    end, 0.5)
end


function Tilemap:check_stability(position)
    local tile = self.tile[position.x][position.y]
    if tile and not tile:is_stable() then
        self:remove(Vector(position.x, position.y))
    end
end


--- @return number, number, number, number
function Tilemap:get_box(tile_position)

    local position = self:get_world_position(tile_position)
    return position.x - self.tile_size.x, position.y - self.tile_size.y, position.x + self.tile_size.x, position.y + self.tile_size.y
end


function Tilemap:get_position(position)

    return Vector(
        math.floor((position.x - self.position.x) / self.tile_size.x) + 1,
        math.floor((position.y - self.position.y) / self.tile_size.y) + 1
        )
end


function Tilemap:get_world_position(position)

    return Vector(
        self.tile_size.x / 2 + self.position.x + (position.x - 1) * self.tile_size.x, 
        self.tile_size.y / 2 + self.position.y + (position.y - 1) * self.tile_size.y)
end


function Tilemap:get_draw_position(position)

    return game.map:get_draw_position(self:get_world_position(position))
end


function Tilemap:update(dt)

    for x, line in pairs(self.tile) do
        for y, tile in pairs(line) do
            tile:update(dt)
        end
    end
end


function Tilemap:draw()

    for x, line in pairs(self.tile) do
        for y, tile in pairs(line) do
            tile:draw()
        end
    end
end


return Tilemap
