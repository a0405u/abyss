local Vector3 = class("Vector3")


--- @class Vector3
--- @field x number
--- @field y number
--- @field z number

--- @param x number
--- @param y number
--- @param z number
function Vector3:init(x, y, z)

    self.x = x or 0.0
    self.y = y or 0.0
    self.z = z or 0.0
end


function Vector3:length()

    return math.sqrt((self.x * self.x) + (self.y * self.y) + (self.z * self.z))
end


function Vector3:normalized()

    local length = self:length()
    if length == 0.0 then return Vector3() end
    return Vector3(self.x / length, self.y / length, self.z / length)
end


function Vector3:normalize()

    local length = self:length()
    if length == 0.0 then return end
    self.x = self.x / length
    self.y = self.y / length
    self.z = self.z / length
end


function Vector3:inverted()

    return Vector3(-self.x, -self.y, -self.z)
end


--- @param vector Vector3
function Vector3:clone(vector)
    self.x = vector.x
    self.y = vector.y
    self.z = vector.z
end


--- @param vector Vector3
function Vector3:add(vector)
    self.x = self.x + vector.x
    self.y = self.y + vector.y
    self.z = self.z + vector.z
end


--- @param n number
function Vector3:add_number(n)
    self.x = self.x + n
    self.y = self.y + n
    self.z = self.z + n
end


--- @param vector Vector3
function Vector3:sub(vector)
    self.x = self.x - vector.x
    self.y = self.y - vector.y
    self.z = self.z - vector.z
end

--- @param n number
function Vector3:sub_number(n)
    self.x = self.x - n
    self.y = self.y - n
    self.z = self.z - n
end


function Vector3:nullify()
    self.x = 0
    self.y = 0
    self.z = 0
end


function Vector3:clamp(min, max)

    local length = self:length()
    local normal = {x = self.x / length, y = self.y / length, z = self.z / length}
    length = math.clamp(length, min, max)
    self.x = normal.x * length
    self.y = normal.y * length
    self.z = normal.z * length
end

return Vector3