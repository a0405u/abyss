--- @class Sawmill: Building
local Sawmill = class("Sawmill", Building)


function Sawmill:init(position, rotation)

    Building.init(self, position, rotation, sprites.sawmill)
    self.income = INCOME_SAWMILL
    self.cost = COST_SAWMILL
end


function Sawmill:update(dt)

    Building.update(self, dt)
    game.economy:add(self.income, dt)
end


return Sawmill
