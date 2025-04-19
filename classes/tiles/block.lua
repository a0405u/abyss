--- @class Block: Tile
local Block = class("Block", Tile)


function Block:init()
    Tile.init(self, sprites.block)
    self.cost = COST_BLOCK
end


function Block:instantiate()

    return Block()
end


return Block
