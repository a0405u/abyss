--- @class Button : UIElement
--- @field icon Sprite
local Button = class("Button", UIElement)

--- @param position Vector
--- @param sprite Sprite | nil
--- @param icon Sprite | nil
--- @param size Vector | nil
--- @param disabled boolean | nil
--- @param on_click function | nil
--- @param parent CanvasArea | nil
function Button:init(position, sprite, icon, size, disabled, on_click, parent, activate)

    UIElement.init(self, sprite or sprites.ui.button, DL_UI_BUTTON, position, size, disabled, parent)
    self.icon = icon and icon:instantiate() or sprites.ui.icons.empty:instantiate()
    self.on_click = on_click
    self:set_state("idle")
    if disabled then self:set_state("disabled") end
    if activate then self:activate(true) end
end


function Button:press(position, button)

    if UIElement.press(self, position, button) == self then
        self:set_state("press")
        return self
    end
end


function Button:release(position, button)

    if self.disabled then return end
    if UIElement.release(self, position, button) == self then
        if self.state == "press" then
            self:activate()
        end
        return self
    end
    self:set_state("idle")
end


function Button:set_state(state)

    self.state = state
    self.sprite:set(self.sprite.animations[state])
end


function Button:disable()

    self.disabled = true
    self:set_state("disabled")
end


function Button:enable()

    self.disabled = false
    self:set_state("idle")
end


function Button:activate(silent)

    if not silent then audio.play(sound.select) end
    if self.parent.active then self.parent.active:deactivate() end
    self.parent.active = self
    self:set_state("active")
    self:on_click()
end


function Button:deactivate()

    self:set_state("idle")
end


function Button:draw()

    self.sprite:draw(DL_UI_BUTTON, self.position)
    local alpha = (self.disabled and 0.4) or 1
    self.icon:draw(DL_UI_ICON, self.position + self.sprite.size / 2, nil, nil, nil, nil, alpha)
end


return Button
