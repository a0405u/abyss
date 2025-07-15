--- @class BuildingSoil: Building
local BuildingSoil = class("BuildingSoil", Building)


function BuildingSoil:init(position, rotation)

    Building.init(self, position, rotation, sprites.buildings.soil)
    self.cost = COST_SOIL
end


return BuildingSoil
