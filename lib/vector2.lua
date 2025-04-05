local vector2 = {}


function vector2.length(x, y)

    return math.sqrt((x * x) + (y * y))
end


function vector2.normalize(x, y)

    local length = vector2.length(x, y)
    return x / length, y / length
end


function vector2:invert(x, y)

    return -x, -y
end


function vector2:add(ax, ay, bx, by)
    return ax + bx, ay + by
end


function vector2:addn(x, y, n)
    return x + n, y + n
end


function vector2:sub(ax, ay, bx, by)
    return ax - bx, ay - by
end


function vector2:subn(x, y, n)
    return x - n, y - n
end


return vector2