--- @class Tree : Tile
local Tree = class("Tree", Tile)


function Tree:init()
    Tile.init(self, sprites.tree[math.random(3)])
    -- self.body:setActive(false)
    self.fixture:setMask(PC_PLAYER)
    self.fixture:setSensor(true)

    self.solid = false
    self.support = false
    self.cost = COST_TREE
    self.dl = DL_TREE
end


function Tree:instantiate()

    return Tree()
end


return Tree
