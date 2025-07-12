--- @class BuildingArch: Building
local BuildingArch = class("BuildingArch", Building)


function BuildingArch:init(position, rotation)

    Building.init(self, position, rotation, sprites.buildings.arch)
    self.cost = COST_SOIL
end


function BuildingArch:update(dt)

    Building.update(self, dt)
end


function BuildingArch:place(position)

    Building.place(self, position)

    for i, fixture in ipairs(self.fixtures) do
        fixture:setCategory(PC_BLOCK)
        fixture:setMask()
    end
end


function BuildingArch:postsolve(a, b, contact, normalimpulse, tangentimpulse)

    -- audio.play(sound.collide)
    -- if normalimpulse > 1000 then print(normalimpulse) end
    -- print(self.body:getMass())
    if normalimpulse > self.strength then
        self.update = function(dt) self:destroy(contact.position) end
        return
    end
end


return BuildingArch
