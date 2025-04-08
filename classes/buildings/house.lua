--- @class House: Building
local House = class("House", Building)


function House:init(position, rotation)

    Building.init(self, position, rotation, sprites.house)
    self.income = INCOME_HOUSE
    self.cost = COST_HOUSE
end


function House:update(dt)

    Building.update(self, dt)
    game.economy:add(self.income, dt)
end


return House
