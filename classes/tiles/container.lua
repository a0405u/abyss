--- @class Container : Tile
local TileContainer = class("TileContainer", Tile)


function TileContainer:init()
    Tile.init(self)
end


function TileContainer:instantiate()

    return TileContainer()
end


function TileContainer:is_stable()

    if Tile.is_stable(self) then
        if self.position.y <= 1 then return true end
        local tile = self.map.tile[self.position.x - 1][self.position.y - 1]
        if not tile or not tile.support then return false end
        local tile = self.map.tile[self.position.x + 1][self.position.y - 1]
        if not tile or not tile.support then return false end
        return true
    end
    return false
end

return TileContainer
