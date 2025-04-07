--- @class Mine: Building
local Mine = class("Mine", Building)


function Mine:init(position, rotation)

    Building.init(self, position, rotation, sprites.mine)
    self.income = INCOME_MINE
    self.cost = COST_MINE
end


function Mine:update(dt)

    Building.update(self, dt)
    game.economy:add(self.income, dt)
end


return Mine
