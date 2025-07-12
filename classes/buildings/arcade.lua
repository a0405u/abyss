--- @class BuildingArcade: Building
local BuildingArcade = class("BuildingArcade", Building)


function BuildingArcade:init(position, rotation)

    Building.init(self, position, rotation, sprites.buildings.arcade)
    self.cost = COST_SOIL
end


function BuildingArcade:update(dt)

    Building.update(self, dt)
end


function BuildingArcade:place(position)

    Building.place(self, position)

    for i, fixture in ipairs(self.fixtures) do
        fixture:setCategory(PC_BLOCK)
        fixture:setMask()
    end
end


function BuildingArcade:postsolve(a, b, contact, normalimpulse, tangentimpulse)

    -- audio.play(sound.collide)
    -- if normalimpulse > 1000 then print(normalimpulse) end
    -- print(self.body:getMass())
    if normalimpulse > self.strength then
        self.update = function(dt) self:destroy(contact.position) end
        return
    end
end


return BuildingArcade
