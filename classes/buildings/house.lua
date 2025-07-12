--- @class BuildingHouse: Building
local BuildingHouse = class("BuildingHouse", Building)


function BuildingHouse:init(position, rotation)

    Building.init(self, position, rotation, sprites.buildings.house)
    self.income = INCOME_HOUSE
    self.cost = COST_HOUSE
end


function BuildingHouse:instantiate()

    return BuildingHouse(self.position, self.rotation)
end


function BuildingHouse:update(dt)

    Building.update(self, dt)
    game.economy:add(self.income, dt)
end


return BuildingHouse
