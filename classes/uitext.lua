--- @class UIText : CanvasArea
local UIText = class("UIText", CanvasArea)

--- Creates new UIText
--- @param text string
--- @param dl number
--- @param position Vector
--- @param size Vector|nil
--- @param disabled boolean|nil
--- @param parent Object|nil
function UIText:init(text, dl, position, size, disabled, parent)
    assert(text, "No text in UIText")

    local x, y = font.small:getWidth(text), font.small:getHeight()
    CanvasArea.init(self, position, size or Vector(x, y), disabled, parent)
    self.dl = dl or DL_UI_TEXT
end


function UIText:draw()
    ui.print(self.text)
end


return UIText
