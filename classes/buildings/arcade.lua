--- @class BuildingArcade: BuildingSupport
local BuildingArcade = class("BuildingArcade", BuildingSupport)


function BuildingArcade:init(position, rotation)

    BuildingSupport.init(self, position, rotation, sprites.buildings.arcade)
end


return BuildingArcade
