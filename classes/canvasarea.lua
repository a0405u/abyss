--- @class CanvasArea : Object
--- @field position Vector
--- @field size Vector
--- @field offset Vector
--- @field parent Object
local CanvasArea = class("CanvasArea", Object)

--- @param position Vector
--- @param size Vector
--- @param disabled boolean | nil
--- @param parent Object | nil
function CanvasArea:init(position, size, disabled, parent)

    Object.init(self, parent)
    self.position = position
    self.size = size
    self.border = {
        left = self.position.x,
        right = self.position.x + self.size.x,
        top = self.position.y,
        bottom = self.position.y + self.size.y,
    }
    self.disabled = disabled or false
end


function CanvasArea:is_inside(position)

    if position.x < self.border.left or position.x > self.border.right then
        return false
    end
    if position.y < self.border.top or position.y > self.border.bottom then
        return false
    end
    return true
end

--- Returns most right (new) child in the subtree or root
--- @param position Vector
--- @param button number Mouse button number
--- @return CanvasArea | nil
function CanvasArea:press(position, button)

    local pressed = self
    for key, child in pairs(self.children) do
        if not child.disabled and child:is_inside(position) then  
            pressed = child:press(position, button) or pressed
        end
    end
    return pressed
end


function CanvasArea:release(position, button)

    local released = self
    for key, child in pairs(self.children) do
        if not child.disabled and child:is_inside(position) then  
            released = child:release(position, button) or pressed
        end
    end
    return released
end


function CanvasArea:update(dt)

end


return CanvasArea
