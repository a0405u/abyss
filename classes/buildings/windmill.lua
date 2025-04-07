--- @class Windmill: Building
local Windmill = class("Windmill", Building)


function Windmill:init(position, rotation)

    Building.init(self, position, rotation, sprites.windmill)
end


return Windmill
