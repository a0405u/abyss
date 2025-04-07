--- @class Block: Tile
local Block = class("Block", Tile)


function Block:init()
    Tile.init(self, sprites.block)
end


return Block
