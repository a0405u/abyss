--- @class Window
--- @field size Vector
--- @field fullscreen boolean
--- @field borderless boolean
--- @field title string
local Window = class("Window")


function Window:init(size, fullscreen, borderless, title)

    self.size = size
    self.fullscreen = fullscreen or config.window.fullscreen
    self.borderless = borderless or config.window.borderless
    self.title = title or config.screen.title

    love.window.setTitle(config.screen.title)
    self:set_mode()
end


--- @param size Vector | nil
--- @param fullscreen boolean | nil
--- @param borderless boolean | nil
function Window:set_mode(size, fullscreen, borderless)

    if fullscreen ~= nil then self.fullscreen = fullscreen end
    if borderless ~= nil then self.borderless = borderless end
    if self.fullscreen then size = Vector(love.window.getDesktopDimensions()) end
    self.size = size or self.size
    love.window.setMode(self.size.x, self.size.y, {fullscreen = self.fullscreen, borderless = self.borderless})
end


return Window