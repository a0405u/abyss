--- @class BuildingBlock: Building
local BuildingBlock = class("BuildingBlock", Building)


function BuildingBlock:init(position, rotation, sprite)

    Building.init(self, position, rotation, sprite or sprites.buildings.block)
    self.cost = COST_BLOCK
    self.category = PC_BLOCK
    self.durability = DUR_BLOCK
    self.mask = {PC_BEAM}
end


-- function BuildingBlock:postsolve(a, b, contact, normalimpulse, tangentimpulse)

    -- audio.play(sound.collide)
    -- if normalimpulse > 1000 then print(normalimpulse) end
    -- print(self.body:getMass())
    -- self.dimpulse = self.dimpulse + normalimpulse + math.abs(tangentimpulse)
-- end


return BuildingBlock
