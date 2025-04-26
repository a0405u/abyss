--- @class Soil : Tile
local Soil = class("Soil", Tile)


function Soil:init()
    Tile.init(self, sprites.soil[math.random(#sprites.soil)])
    self.cost = COST_SOIL
end


function Soil:instantiate()

    return Soil()
end


function Soil:is_stable()

    if Tile.is_stable(self) then
        if self.position.y <= 1 then return true end
        local tile = self.map.tile[self.position.x - 1][self.position.y - 1]
        if not tile or not tile.solid then return false end
        local tile = self.map.tile[self.position.x + 1][self.position.y - 1]
        if not tile or not tile.solid then return false end
        return true
    end
    return false
end

return Soil
