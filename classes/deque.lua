--- @class Deque
local Deque = class("Deque")


function Deque:init()

    self.first = 1
    self.last = -1
end


function Deque:push_left(list, value)

    local first = list.first - 1
    list.first = first
    list[first] = value
end


function Deque:push_right(list, value)

    local last = list.last + 1
    list.last = last
    list[last] = value
end


function Deque:pop_left(list)

    local first = list.first
    if first > list.last then error("list is empty") end
    local value = list[first]
    list[first] = nil        -- to allow garbage collection
    list.first = first + 1
    return value
end


function Deque:pop_right(list)

    local last = list.last
    if list.first > last then error("list is empty") end
    local value = list[last]
    list[last] = nil         -- to allow garbage collection
    list.last = last - 1
    return value
end


return Deque
