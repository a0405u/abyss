local vector3 = {}


function vector3.length(x, y, z)

    return math.sqrt((x * x) + (y * y) + (z * z))
end


function vector3.normalize(x, y, z)

    local length = vector3.length(x, y, z)
    return x / length, y / length, z / length
end


function vector3:invert(x, y, z)

    return -x, -y, -z
end


function vector3:add(ax, ay, az, bx, by, bz)
    return ax + bx, ay + by, az + bz
end


function vector3:addn(x, y, z, n)
    return x + n, y + n, z + n
end


function vector3:sub(ax, ay, az, bx, by, bz)
    return ax - bx, ay - by, az - bz
end


function vector3:subn(x, y, z, n)
    return x - n, y - n, z - n
end


return vector3