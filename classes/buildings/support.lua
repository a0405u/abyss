--- @class BuildingSupport: Building
local BuildingSupport = class("BuildingSupport", Building)


function BuildingSupport:init(position, rotation)

    Building.init(self, position, rotation, sprites.buildings.support)
    self.cost = COST_SOIL
end


function BuildingSupport:update(dt)

    Building.update(self, dt)
end


function BuildingSupport:place(position)

    Building.place(self, position)

    for i, fixture in ipairs(self.fixtures) do
        fixture:setCategory(PC_BLOCK)
        fixture:setMask()
    end
end


function BuildingSupport:postsolve(a, b, contact, normalimpulse, tangentimpulse)

    -- audio.play(sound.collide)
    -- if normalimpulse > 1000 then print(normalimpulse) end
    -- print(self.body:getMass())
    if normalimpulse > self.strength then
        self.update = function(dt) self:destroy(contact.position) end
        return
    end
end


return BuildingSupport
