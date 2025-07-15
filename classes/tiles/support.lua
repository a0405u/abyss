--- @class Support : Tile
local TileSupport = class("TileSupport", Tile)


function TileSupport:init()
    Tile.init(self, sprites.tiles.support[math.random(#sprites.tiles.support)])
    -- self.body:setActive(false)
    self.fixture:setMask(PC_PLAYER)
    self.fixture:setSensor(true)

    self.solid = false
    self.cost = COST_SUPPORT
    self.dl = DL_SUPPORT
    self.sprite:set(self.sprite.animations.top)
end


function TileSupport:clone()

    return TileSupport()
end


function TileSupport:update_position()

    local tile_under = self.map.tile[self.position.x][self.position.y - 1]
    local tile_over = self.map.tile[self.position.x][self.position.y + 1]
    if tile_over and tile_over:is(TileSupport) then
        self.sprite:set(self.sprite.animations.middle)
    else
        self.sprite:set(self.sprite.animations.top)
    end
    if self.position.y > 1 and (not tile_under or not tile_under.support) then
        self.sprite:set(self.sprite.animations.arch)
    end
end


function TileSupport:check_support(position)
    local left = self.map.tile[position.x - 1][position.y]
    local tile = self.map.tile[position.x][position.y]
    local right = self.map.tile[position.x + 1][position.y]
    if tile and (tile:is(TileBlock) or tile:is(TileSoil)) then return true end
    if tile and (tile:is(TileBlock) or tile:is(TileSoil)) and
        left and (left:is(TileBlock) or left:is(TileSoil)) and
        right and (right:is(TileBlock) or right:is(TileSoil)) then
        return true 
    end
    return false
end


function TileSupport:is_stable()

    if Tile.is_stable(self) then

        if self.position.y <= 3 then return true end

        if self:check_support(Vector(self.position.x, self.position.y - 1)) then
            return true
        end
        if self:check_support(Vector(self.position.x, self.position.y - 2)) then
            return true
        end
        if self:check_support(Vector(self.position.x, self.position.y - 3)) then
            return true
        end
    else
        local tile = self.map.tile[self.position.x - 1][self.position.y]
        if not tile or not tile.support then return false end
        local tile = self.map.tile[self.position.x + 1][self.position.y]
        if not tile or not tile.support then return false end
        return true
    end
    return false
end

return TileSupport
