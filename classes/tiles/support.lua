--- @class Support : Tile
local Support = class("Support", Tile)


function Support:init()
    Tile.init(self, sprites.support[math.random(#sprites.support)])
    -- self.body:setActive(false)
    self.fixture:setMask(PC_PLAYER)
    self.fixture:setSensor(true)

    self.solid = false
    self.cost = COST_SUPPORT
    self.dl = DL_SUPPORT
    self.sprite:set(self.sprite.animations.top)
end


function Support:instantiate()

    return Support()
end


function Support:update_position()

    local tile_under = self.map.tile[self.position.x][self.position.y - 1]
    local tile_over = self.map.tile[self.position.x][self.position.y + 1]
    if tile_over and tile_over:is(Support) then
        self.sprite:set(self.sprite.animations.middle)
    else
        self.sprite:set(self.sprite.animations.top)
    end
    if self.position.y > 1 and (not tile_under or not tile_under.support) then
        self.sprite:set(self.sprite.animations.arch)
    end
end


function Support:check_support(position)
    local left = self.map.tile[position.x - 1][position.y]
    local tile = self.map.tile[position.x][position.y]
    local right = self.map.tile[position.x + 1][position.y]
    if tile and (tile:is(Block) or tile:is(Soil)) and
        left and (left:is(Block) or left:is(Soil)) and
        right and (right:is(Block) or right:is(Soil)) then
        return true 
    end
    return false
end


function Support:is_stable()

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

return Support
