--- @class BuildingSupport: BuildingBlock
local BuildingSupport = class("BuildingSupport", BuildingBlock)


function BuildingSupport:init(position, rotation, sprite)

    BuildingBlock.init(self, position, rotation, sprite or sprites.buildings.support)
    self.cost = COST_SOIL
    self.category = PC_BGBLOCK
    self.mask = {PC_PLAYER, PC_BEAM}
    self.dl = DL_SUPPORT
end


return BuildingSupport
