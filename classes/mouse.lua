local Mouse = class("Mouse")

--- @class Mouse
--- @field sprite Sprite
--- @field position Vector

--- @param sprite Sprite
--- @param position Vector|nil
--- @param visible boolean|nil
function Mouse:init(sprite, visible, position)

    self.sprite = sprite or sprites.ui.mouse:clone()
    self.visible = visible or true
    self.position = {
        window = position or Vector(0, 0),
        screen = Vector(0, 0),
        map = Vector(0, 0)
    }
    self.plank = nil
    self.button = nil
end


function Mouse:draw()

    if self.visible then
        self.sprite:draw(DL_UI_MOUSE, self.position.screen)
        -- deep.queue(mouse.dq, function() mouse.sprite:draw(mouse.posx, mouse.posy) end)
    end
end


function Mouse:pressed(x, y, button, istouch, presses)

    local position = self:get_map_position(x, y)
    local pressed = ui:press(self:get_screen_position(x, y), button)
    if pressed and pressed:is(Button) then
        self.button = pressed
        return
    end

    if button == 1 then
        game:activate(position)
        game.hand:stop()
        return
    end
    if button == 2 then
        game.hand:use(position)
        game.tool:secondary()
    end
end


function Mouse:released(x, y, button, istouch, presses)

    local position = self:get_map_position(x, y)
    local screen_position = self:get_screen_position(x, y)
    local released = ui:release(screen_position, button)
    if self.button and released ~= self.button then
        self.button:release(screen_position)
        self.button = nil
        return
    end

    if button == 2 then
        game.hand:stop()
    end
end


function Mouse:update(dt)

    local x, y = love.mouse.getPosition()
    self.position.window.x, self.position.window.y = x, y
    self.position.screen = self:get_screen_position(x, y)
    self.position.map = self:get_map_position(x, y)
    self.sprite:update(dt)

    if self.building then
        self.building:set_position(self.position.map)
    end
end


function Mouse:state(state)

    state = state or "Idle"
    self.sprite:setTag(state)
end


function Mouse:get_screen_position(x, y)

    return Vector(math.floor(x / screen.scale), math.floor(y / screen.scale))
end


function Mouse:normalize_to_camera(position)

    return Vector(position.x - game.camera.position.x, position.y)
end


function Mouse:get_map_position(x, y)

    return game.map:get_position(self:get_screen_position(x, y))
end


return Mouse