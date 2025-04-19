--- @class Soil
local Soil = class("Soil", Tile)


function Soil:init()
    Tile.init(self, sprites.soil)
    self.cost = COST_SOIL
end


function Soil:instantiate()

    return Soil()
end


return Soil
