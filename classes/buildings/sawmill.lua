--- @class Sawmill: Building
local Sawmill = class("Sawmill", Building)


function Sawmill:init(position, rotation)

    Building.init(self, position, rotation, sprites.sawmill)
    self.income = INCOME_SAWMILL
    self.cost = COST_SAWMILL
end


function Sawmill:update(dt)

    Building.update(self, dt)
    local position = game.map.tilemap:get_position(self.position)
    local tiles = game.map.tilemap:find(Vector(position.x - 1, position.y - 1), Vector(position.x + 1, position.y + 1), Tree)
    local mult = #tiles * MLT_TREE + 1
    game.economy:add({
        wood = self.income.wood * mult,
        stone = self.income.stone * mult,
        food = self.income.food * mult,
    }, dt)
end


return Sawmill
