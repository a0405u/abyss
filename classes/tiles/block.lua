--- @class Block: Tile
local TileBlock = class("TileBlock", Tile)


function TileBlock:init()
    Tile.init(self, sprites.tiles.block[math.random(#sprites.tiles.block)])
    self.cost = COST_BLOCK
end


function TileBlock:clone()

    return TileBlock()
end


function TileBlock:check_support(position)
    local left = self.map.tile[position.x - 1][position.y]
    local tile = self.map.tile[position.x][position.y]
    local right = self.map.tile[position.x + 1][position.y]
    if tile and tile.support and left and left.support and right and right.support then
        return true
    end
    return false
end


function TileBlock:is_stable()

    if Tile.is_stable(self) then

        if self.position.y <= 2 then return true end

        local tile = self.map.tile[self.position.x][self.position.y - 1]
        if tile and tile:is(TileSupport) then return true end

        if self:check_support(Vector(self.position.x, self.position.y - 1)) then
            return true
        end

        if self:check_support(Vector(self.position.x, self.position.y - 2)) then
            return true
        end
    end
    return false
end


return TileBlock
