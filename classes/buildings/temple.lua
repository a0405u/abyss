--- @class BuildingTemple: Building
local BuildingTemple = class("BuildingTemple", Building)


function BuildingTemple:init(position, rotation)

    Building.init(self, position, rotation, sprites.buildings.temple)
    game.temple = self
end


function BuildingTemple:update(dt)

    Building.update(self, dt)
end


return BuildingTemple
