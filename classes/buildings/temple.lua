--- @class Temple: Building
local Temple = class("Temple", Building)


function Temple:init(position, rotation)

    Building.init(self, position, rotation, sprites.temple)
    game.temple = self
end


function Temple:update(dt)

    Building.update(self, dt)
end


return Temple
