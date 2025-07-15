--- @class UIElement : CanvasArea
local UIElement = class("UIElement", CanvasArea)

--- Creates new UIElement
--- @param sprite Sprite
--- @param dl number
--- @param position Vector
--- @param size Vector|nil
--- @param disabled boolean|nil
--- @param parent Object|nil
function UIElement:init(sprite, dl, position, size, disabled, parent)
    assert(sprite, "No sprite in UIElement")

    CanvasArea.init(self, position, size or sprite:get_size(), disabled, parent)
    self.sprite = sprite:clone()
    self.dl = dl or DL_UI
end


function UIElement:update(dt)
    self.sprite:update(dt)
end


function UIElement:draw()
    self.sprite:draw(self.dl, self.position)
    CanvasArea.draw(self)
end


return UIElement
