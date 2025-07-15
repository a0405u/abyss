--- @class BuildingMine: Building
local BuildingMine = class("BuildingMine", Building)


function BuildingMine:init(position, rotation)

    Building.init(self, position, rotation, sprites.buildings.mine)
    self.income = INCOME_MINE
    self.cost = COST_MINE
end


function BuildingMine:clone()

    return BuildingMine(self.position, self.rotation)
end


function BuildingMine:update(dt)

    Building.update(self, dt)
    game.economy:add(self.income, dt)
end


return BuildingMine
