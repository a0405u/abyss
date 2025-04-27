--- @class Soil : Tile
local Soil = class("Soil", Tile)


function Soil:init()
    Tile.init(self, sprites.soil[math.random(#sprites.soil)])
    self.cost = COST_SOIL
end


function Soil:instantiate()

    return Soil()
end


function Soil:check_support(position)
    local left = self.map.tile[position.x - 1][position.y]
    local tile = self.map.tile[position.x][position.y]
    local right = self.map.tile[position.x + 1][position.y]
    if tile and tile.support and left and left.support and right and right.support then
        return true
    end
    return false
end


function Soil:is_stable()

    if Tile.is_stable(self) then

        if self.position.y <= 1 then return true end

        local tile = self.map.tile[self.position.x][self.position.y - 1]
        if tile and tile:is(Support) then return true end

        if self:check_support(Vector(self.position.x, self.position.y - 1)) then
            return true
        end
    end
    return false
end

return Soil
