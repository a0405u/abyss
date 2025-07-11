--- @class BuildingBlock: Building
local BuildingBlock = class("BuildingBlock", Building)


function BuildingBlock:init(position, rotation)

    Building.init(self, position, rotation, sprites.buildings.block)
    self.cost = COST_BLOCK
end


function BuildingBlock:update(dt)

    Building.update(self, dt)
end


function BuildingBlock:place(position)

    Building.place(self, position)

    for i, fixture in ipairs(self.fixtures) do
        fixture:setCategory(PC_BLOCK)
        fixture:setMask()
    end
end


function BuildingBlock:postsolve(a, b, contact, normalimpulse, tangentimpulse)

    -- audio.play(sound.collide)
    -- if normalimpulse > 1000 then print(normalimpulse) end
    -- print(self.body:getMass())
    if normalimpulse > self.strength then
        self.update = function(dt) self:destroy(contact.position) end
        return
    end
end


return BuildingBlock
