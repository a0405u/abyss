--- @class BuildingSupport: BuildingBlock
local BuildingSupport = class("BuildingSupport", BuildingBlock)


function BuildingSupport:init(position, rotation, sprite)

    BuildingBlock.init(self, position, rotation, sprite or sprites.buildings.support)
    self.cost = COST_SOIL
    self.category = PC_BGBLOCK
    self.mask = PC_PLAYER
    self.dl = DL_SUPPORT
end


function BuildingSupport:instantiate()

    return BuildingSupport(self.position, self.rotation)
end


function BuildingSupport:place(position)

    Building.place(self, position)

    for i, fixture in ipairs(self.fixtures) do
        fixture:setCategory(self.category)
        fixture:setMask(self.mask)
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
