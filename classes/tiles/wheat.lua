--- @class Wheat : Tile
local Wheat = class("Wheat", Tile)


function Wheat:init()
    Tile.init(self, sprites.wheat[math.random(2)])
    -- self.body:setActive(false)
    self.fixture:setMask(PC_PLAYER)
    
    self.cost = COST_WHEAT
    self.dl = DL_WHEAT
end


function Wheat:instantiate()

    return Wheat()
end


return Wheat
