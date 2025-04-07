--- @class Soil
local Soil = class("Soil", Tile)


function Soil:init()
    Tile.init(self, sprites.soil)
end


return Soil
