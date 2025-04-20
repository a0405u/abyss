local Vector = {}


function Vector.length(x, y)

    return math.sqrt((x * x) + (y * y))
end


function Vector.normalize(x, y)

    local length = Vector.length(x, y)
    return x / length, y / length
end


function Vector:invert(x, y)

    return -x, -y
end


function Vector:add(ax, ay, bx, by)
    return ax + bx, ay + by
end


function Vector:addn(x, y, n)
    return x + n, y + n
end


function Vector:sub(ax, ay, bx, by)
    return ax - bx, ay - by
end


function Vector:subn(x, y, n)
    return x - n, y - n
end


return Vector