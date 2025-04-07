--- @class Windmill: Building
local Windmill = class("Windmill", Building)


function Windmill:init(position, rotation)

    Building.init(self, position, rotation, sprites.windmill)
    self.income = INCOME_WINDMILL
    self.cost = COST_WINDMILL
end


function Windmill:update(dt)

    Building.update(self, dt)
    game.economy:add(self.income, dt)
end


return Windmill
