--- @class BuildingSoil: Building
local BuildingSoil = class("BuildingSoil", Building)


function BuildingSoil:init(position, rotation)

    Building.init(self, position, rotation, sprites.buildings.soil)
    self.cost = COST_SOIL
end


function BuildingSoil:instantiate()

    return BuildingSoil(self.position, self.rotation)
end


function BuildingSoil:update(dt)

    Building.update(self, dt)
end


function BuildingSoil:place(position)

    Building.place(self, position)

    for i, fixture in ipairs(self.fixtures) do
        fixture:setCategory(PC_BLOCK)
        fixture:setMask()
    end
end


function BuildingSoil:postsolve(a, b, contact, normalimpulse, tangentimpulse)

    -- audio.play(sound.collide)
    -- if normalimpulse > 1000 then print(normalimpulse) end
    -- print(self.body:getMass())
    if normalimpulse > self.strength then
        self.update = function(dt) self:destroy(contact.position) end
        return
    end
end


return BuildingSoil
