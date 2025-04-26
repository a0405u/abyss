--- @class Block: Tile
local Block = class("Block", Tile)


function Block:init()
    Tile.init(self, sprites.block[math.random(#sprites.block)])
    self.cost = COST_BLOCK
end


function Block:instantiate()

    return Block()
end


function Block:is_stable()

    if Tile.is_stable(self) then
        if self.position.y <= 3 then return true end
        local tile = self.map.tile[self.position.x - 1][self.position.y - 3]
        if not tile or not tile.support then return false end
        local tile = self.map.tile[self.position.x + 1][self.position.y - 3]
        if not tile or not tile.support then return false end
        return true
    end
    return false
end


return Block
