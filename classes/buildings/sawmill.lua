--- @class Sawmill: Building
local Sawmill = class("Sawmill", Building)


function Sawmill:init(position, rotation)

    Building.init(self, position, rotation, sprites.sawmill)
end


return Sawmill
