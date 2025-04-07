--- @class Resource
local Resource = class("Resource")


function Resource:init(value)

    self.value = value or 0
end


function Resource:take(amount)

    self.value = self.value - amount
end


function Resource:has(amount)

    return self.value >= amount
end


function Resource:update(dt)

end


function Resource:draw()

end


return Resource
