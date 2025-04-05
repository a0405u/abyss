local Vector2 = class("Vector2")

--- @class Vector2
--- @field x number
--- @field y number
--- @param x number
--- @param y number
function Vector2:init(x, y)

    self.x = x or 0.0
    self.y = y or 0.0
end


function Vector2:nullify()
    self.x = 0
    self.y = 0
end


function Vector2:length()

    return math.sqrt((self.x * self.x) + (self.y * self.y))
end


function Vector2:normalized()

    local length = self:length()
    if length == 0.0 then return Vector2() end
    return Vector2(self.x / length, self.y / length)
end


function Vector2:normalize()

    local length = self:length()
    if length == 0.0 then return end
    self.x = self.x / length
    self.y = self.y / length
end


function Vector2:inverted()

    return Vector2(-self.x, -self.y)
end


--- @param vector Vector2
function Vector2:copy(vector)
    self.x = vector.x
    self.y = vector.y
end


--- @param x number
--- @param y number
function Vector2:set(x, y)
    self.x = x
    self.y = y
end


--- @param x number
--- @param y number
--- @return number, number
function Vector2:get()
    return self.x, self.y
end


function Vector2:clone()
    return Vector2(self.x, self.y)
end


--- @param vector Vector2
function Vector2:add(vector)
    self.x = self.x + vector.x
    self.y = self.y + vector.y
end


--- @param n number
function Vector2:add_number(n)
    self.x = self.x + n
    self.y = self.y + n
end


--- @param vector Vector2
function Vector2:sub(vector)
    self.x = self.x - vector.x
    self.y = self.y - vector.y
end


--- @param n number
function Vector2:sub_number(n)
    self.x = self.x - n
    self.y = self.y - n
end


--- @param n number
function Vector2:mult(n)
    self.x = self.x * n
    self.y = self.y * n
end


function Vector2:clamp(min, max)

    local length = self:length()
    local normal = {x = self.x / length, y = self.y / length}
    length = math.clamp(length, min, max)
    self.x = normal.x * length
    self.y = normal.y * length
end


return Vector2