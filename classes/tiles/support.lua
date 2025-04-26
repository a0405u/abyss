--- @class Support : Tile
local Support = class("Support", Tile)


function Support:init()
    Tile.init(self, sprites.support_up[math.random(#sprites.support_up)])
    -- self.body:setActive(false)
    self.fixture:setMask(PC_PLAYER)
    self.fixture:setSensor(true)

    self.solid = false
    self.cost = COST_SUPPORT
    self.dl = DL_SUPPORT
end


function Support:instantiate()

    return Support()
end

function Support:is_stable()

    if Tile.is_stable(self) then
        if self.position.y <= 3 then return true end
        local tile = self.map.tile[self.position.x - 1][self.position.y - 3]
        if not tile or not tile.support then return false end
        local tile = self.map.tile[self.position.x + 1][self.position.y - 3]
        if not tile or not tile.support then return false end
        return true
    end
    return false
end

return Support
