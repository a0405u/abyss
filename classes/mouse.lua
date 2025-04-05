local Mouse = class("Mouse")

--- @class Mouse
--- @field sprite Sprite
--- @field position Vector2

--- @param sprite Sprite
--- @param position Vector2|nil
--- @param visible boolean|nil
function Mouse:init(sprite, visible, position)

    self.sprite = sprite
    self.visible = visible or true
    self.position = position or Vector2(0, 0)
    self.plank = nil
end


function Mouse:draw()

    if self.visible then
        self.sprite:draw(self.position)
        -- deep.queue(mouse.dq, function() mouse.sprite:draw(mouse.posx, mouse.posy) end)
    end
end

function Mouse:pressed(x, y, button, istouch, presses)

    local position = self:get_map_position(self:get_screen_position(x, y))

    if not self.plank then
        self.plank = Plank(position)
        game.map:add(self.plank)
        return
    end

    self.plank:unfreeze()
    self.plank = nil
end


function Mouse:released(x, y, button, istouch, presses)

    x, y = self:get_screen_position(x, y)
    local position = self:get_map_position(x, y)
end


function Mouse:update(dt)

    self.position.x, self.position.y = love.mouse.getPosition()
    self.position.x, self.position.y = self:get_screen_position(self.position.x, self.position.y)
    self.sprite:update(dt)

    if self.plank then
        local position = self:get_map_position(self.position.x, self.position.y)
        self.plank:set_point(position)
    end
end


function Mouse:state(state)

    state = state or "Idle"
    self.sprite:setTag(state)
end


function Mouse:get_screen_position(x, y)

    return math.floor(x / screen.scale), math.floor(y / screen.scale)
end


function Mouse:get_map_position(x, y)

    return game.map:get_position(Vector2(x, y))
end

return Mouse