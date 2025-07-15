--- @class BuildingArch: BuildingSupport
local BuildingArch = class("BuildingArch", BuildingSupport)


function BuildingArch:init(position, rotation)

    BuildingSupport.init(self, position, rotation, sprites.buildings.arch)
end


return BuildingArch
