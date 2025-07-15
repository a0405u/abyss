--- @class BuildingWindmill: Building
local BuildingWindmill = class("BuildingWindmill", Building)


function BuildingWindmill:init(position, rotation)

    Building.init(self, position, rotation, sprites.buildings.windmill)
    self.income = INCOME_WINDMILL
    self.cost = COST_WINDMILL
end


function BuildingWindmill:clone()

    return BuildingWindmill(self.position, self.rotation)
end


function BuildingWindmill:update(dt)

    Building.update(self, dt)
    local position = game.map.tilemap:get_position(self.position)
    local tiles = game.map.tilemap:get_tiles_of_type(Vector(position.x - 1, position.y - 1), Vector(position.x + 1, position.y + 1), TileWheat)
    local mult = #tiles * MLT_WHEAT + 1
    game.economy:add({
        wood = self.income.wood * mult,
        stone = self.income.stone * mult,
        food = self.income.food * mult,
    }, dt)
end


return BuildingWindmill
