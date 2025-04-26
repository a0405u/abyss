--- @class Windmill: Building
local Windmill = class("Windmill", Building)


function Windmill:init(position, rotation)

    Building.init(self, position, rotation, sprites.windmill)
    self.income = INCOME_WINDMILL
    self.cost = COST_WINDMILL
end


function Windmill:update(dt)

    Building.update(self, dt)
    local position = game.map.tilemap:get_position(self.position)
    local tiles = game.map.tilemap:get_tiles_of_type(Vector(position.x - 1, position.y - 1), Vector(position.x + 1, position.y + 1), Wheat)
    local mult = #tiles * MLT_WHEAT + 1
    game.economy:add({
        wood = self.income.wood * mult,
        stone = self.income.stone * mult,
        food = self.income.food * mult,
    }, dt)
end


return Windmill
