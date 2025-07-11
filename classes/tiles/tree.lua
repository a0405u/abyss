--- @class Tree : Tile
local TileTree = class("TileTree", Tile)


function TileTree:init()
    Tile.init(self, sprites.tiles.tree[math.random(#sprites.tiles.tree)])
    -- self.body:setActive(false)
    self.fixture:setMask(PC_PLAYER)
    self.fixture:setSensor(true)

    self.solid = false
    self.support = false
    self.cost = COST_TREE
    self.dl = DL_TREE
end


function TileTree:instantiate()

    return TileTree()
end


return TileTree
