--- @class Object
--- @field parent Object|nil
--- @field children table
local Object = class("Object")


--- @param parent Object|nil
function Object:init(parent)

    if parent then
        self.parent = parent
        self.parent:add(self)
    else
        self.parent = nil
    end
    self.children = {}
end


--- @param dt number
function Object:update(dt)

    for key, child in pairs(self.children) do
        child:update(dt)
    end
end


function Object:draw(...)

    for key, child in pairs(self.children) do
        child:draw(...)
    end
end


--- @param child Object
function Object:remove(child)

    self.children[child] = nil
end


--- @param child Object
function Object:add(child)

    self.children[child] = child
    child:set(self)
    return child
end


--- @param parent Object
function Object:set(parent)

    if self.parent then self.parent:remove(self) end
    self.parent = parent
end

return Object
