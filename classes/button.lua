--- @class Button
local Button = class("Button")


function Button:init(parent, position, icon, size, disabled, on_click)

    assert(parent, "No parent in Button!")
    self.parent = parent
    self.position = position
    self.sprite = sprites.ui.button:instantiate()
    self.icon = icon:instantiate() or sprites.ui.icons.empty:instantiate()
    self.on_click = on_click
    self.size = size or self.sprite.size:clone()
    self:set("idle")
    self.disabled = disabled

    if self.disabled then self:disable() end
end


function Button:set(state)

    self.state = state
    self.sprite:set(self.sprite.animations[state])
end


function Button:enable()

    self:set("idle")
end


function Button:disable()
    self:set("disabled")
end

function Button:press()
    if not self.disabled then
        self:set("press")
    end
end


function Button:release()
    if self.state == "press" then
        self:activate()
    end
end


function Button:activate(silent)

    if not silent then audio.play(sound.select) end
    if self.parent.active then 
        self.parent.active:deactivate()
    end
    self.parent.active = self
    self:set("active")
    self:on_click()
end


function Button:deactivate()

    self:set("idle")
end


function Button:update(dt)
end


function Button:draw()

    self.sprite:draw(DL_UI_BUTTON, self.position)
    local alpha = (self.disabled and 0.4) or 1
    self.icon:draw(DL_UI_ICON, self.position, nil, nil, nil, nil, alpha)
end


function Button:is_inside(position)

    return
        position.x > self.position.x - self.size.x / 2 and
        position.x < self.position.x + self.size.x / 2 and
        position.y > self.position.y - self.size.y / 2 and
        position.y < self.position.y + self.size.y / 2
end


return Button
