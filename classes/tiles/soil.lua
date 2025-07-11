--- @class Soil : Tile
local TileSoil = class("TileSoil", Tile)


function TileSoil:init()
    Tile.init(self, sprites.tiles.soil[math.random(#sprites.tiles.soil)])
    self.cost = COST_SOIL
end


function TileSoil:instantiate()

    return TileSoil()
end


function TileSoil:check_support(position)
    local left = self.map.tile[position.x - 1][position.y]
    local tile = self.map.tile[position.x][position.y]
    local right = self.map.tile[position.x + 1][position.y]
    if tile and tile.support and left and left.support and right and right.support then
        return true
    end
    return false
end


function TileSoil:is_stable()

    if Tile.is_stable(self) then

        if self.position.y <= 1 then return true end

        local tile = self.map.tile[self.position.x][self.position.y - 1]
        if tile and tile:is(TileSupport) then return true end

        if self:check_support(Vector(self.position.x, self.position.y - 1)) then
            return true
        end
    end
    return false
end

return TileSoil
