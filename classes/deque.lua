--- @class Deque
local Deque = class("Deque")


function Deque:init()

    self.first = 1
    self.last = -1
end


function Deque:push_left(value)

    local first = self.first - 1
    self.first = first
    self[first] = value
end


function Deque:push_right(value)

    local last = self.last + 1
    self.last = last
    self[last] = value
end


function Deque:pop_left()

    local first = self.first
    if first > self.last then return end
    local value = self[first]
    self[first] = nil        -- to allow garbage collection
    self.first = first + 1
    return value
end


function Deque:pop_right()

    local last = self.last
    if self.first > last then return end
    local value = self[last]
    self[last] = nil         -- to allow garbage collection
    self.last = last - 1
    return value
end


return Deque
