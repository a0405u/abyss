--- @class BuildingSoil: BuildingBlock
local BuildingSoil = class("BuildingSoil", BuildingBlock)


function BuildingSoil:init(position, rotation)

    BuildingBlock.init(self, position, rotation, sprites.buildings.soil, DL_TILE)
    self.cost = COST_SOIL
    self.durability = DUR_SOIL
    self.category = {PC_BLOCK}
    self.mask = {PC_BEAM}
end


return BuildingSoil
