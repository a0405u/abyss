--- @class Wheat : Tile
local TileWheat = class("TileWheat", Tile)


function TileWheat:init()
    Tile.init(self, sprites.tiles.wheat[math.random(#sprites.tiles.wheat)])
    -- self.body:setActive(false)
    self.fixture:setMask(PC_PLAYER)
    self.fixture:setSensor(true)
    
    self.solid = false
    self.support = false
    self.cost = COST_WHEAT
    self.dl = DL_WHEAT
end


function TileWheat:clone()

    return TileWheat()
end


return TileWheat
