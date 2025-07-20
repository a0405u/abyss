--- @class BuildingSupport: BuildingBlock
local BuildingSupport = class("BuildingSupport", BuildingBlock)

--- comment
--- @param position Vector|nil
--- @param rotation number|nil
--- @param sprite Sprite
function BuildingSupport:init(position, rotation, sprite)

    BuildingBlock.init(self, position, rotation, sprite or sprites.buildings.support, DL_SUPPORT)
    self.cost = COST_SOIL
    self.category = {PC_BLOCK, PC_BACKGROUND}
    self.mask = {PC_PLAYER, PC_BUILDING, PC_BEAM, PC_PLANK, PC_WALL, PC_PLATFORM}
end


return BuildingSupport
