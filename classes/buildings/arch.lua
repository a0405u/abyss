--- @class BuildingArch: BuildingSupport
local BuildingArch = class("BuildingArch", BuildingSupport)


function BuildingArch:init(position, rotation)

    BuildingSupport.init(self, position, rotation, sprites.buildings.arch)
end


function BuildingArch:instantiate()

    return BuildingArch(self.position, self.rotation)
end


return BuildingArch
