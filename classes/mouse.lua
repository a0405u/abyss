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
        self.sprite:draw(DL_UI_MOUSE, self.position.screen)
        -- deep.queue(mouse.dq, function() mouse.sprite:draw(mouse.posx, mouse.posy) end)
    end
end

function Mouse:pressed(x, y, button, istouch, presses)

    local position = self:get_map_position(x, y)
    local ui_button = ui.get_button(self:get_screen_position(x, y))

    if ui_button then
        ui_button:press()
        return
    end

    if button == 1 then
        game:activate(position)

        if game.player:in_range(position, game.player.range * 2) then

            if self.building then
                self.building:activate()
                self.building = nil
                return
            end
        else
            -- game.player.sphere.show(game.player.range * 2)
        end
        return
    end
    if button == 2 then
    end
end


function Mouse:released(x, y, button, istouch, presses)

    local position = self:get_map_position(x, y)

    local ui_button = ui.get_button(self:get_screen_position(x, y))

    if ui_button then
        ui_button:release()
        return
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

    return Vector2(math.floor(x / screen.scale), math.floor(y / screen.scale))
end


function Mouse:get_map_position(x, y)

    return game.map:get_position(self:get_screen_position(x, y))
end


return Mouse