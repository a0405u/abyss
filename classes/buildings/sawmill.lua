--- @class BuildingSawmill: Building
local BuildingSawmill = class("BuildingSawmill", Building)


function BuildingSawmill:init(position, rotation)

    Building.init(self, position, rotation, sprites.buildings.sawmill)
    self.income = INCOME_SAWMILL
    self.cost = COST_SAWMILL
end


function BuildingSawmill:instantiate()

    return BuildingSawmill(self.position, self.rotation)
end


function BuildingSawmill:update(dt)

    Building.update(self, dt)
    local position = game.map.tilemap:get_position(self.position)
    local tiles = game.map.tilemap:get_tiles_of_type(Vector(position.x - 1, position.y - 1), Vector(position.x + 1, position.y + 1), TileTree)
    local mult = #tiles * MLT_TREE + 1
    game.economy:add({
        wood = self.income.wood * mult,
        stone = self.income.stone * mult,
        food = self.income.food * mult,
    }, dt)
end


return BuildingSawmill
