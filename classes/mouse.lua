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
    self.position = {
        window = position or Vector2(0, 0),
        screen = Vector2(0, 0),
        map = Vector2(0, 0)
    }
    self.plank = nil
end


function Mouse:draw()

    if self.visible then
        self.sprite:draw(DL_MOUSE, self.position.screen)
        -- deep.queue(mouse.dq, function() mouse.sprite:draw(mouse.posx, mouse.posy) end)
    end
end

function Mouse:pressed(x, y, button, istouch, presses)

    local position = self:get_map_position(x, y)

    if self.plank then
        self.plank:activate()
        self.plank:add_nail(self.plank.point)
        self.plank:add_nail(self.plank.position)
        self.plank = nil
        return
    end

    if self.building and game.player:in_range(position) then
        self.building:activate()
        self.building = nil
        return
    end

    if game.player:in_range(position) then
        self.plank = Plank(position)
        game.map:add(self.plank)
    end
end


function Mouse:released(x, y, button, istouch, presses)

    local position = self:get_map_position(x, y)
end


function Mouse:update(dt)

    local x, y = love.mouse.getPosition()
    self.position.window.x, self.position.window.y = x, y
    self.position.screen = self:get_screen_position(x, y)
    self.position.map = self:get_map_position(x, y)
    self.sprite:update(dt)

    if self.plank then
        self.plank:set_point(self.position.map)
        return
    end
    if self.building then
        self.building:set_position(self.position.map)
    end
end


function Mouse:state(state)

    state = state or "Idle"
    self.sprite:setTag(state)
end


function Mouse:get_screen_position(x, y)

    return Vector2(math.floor(x / screen.scale), math.floor(y / screen.scale))
end


function Mouse:get_map_position(x, y)

    return game.map:get_position(self:get_screen_position(x, y))
end


return Mouse