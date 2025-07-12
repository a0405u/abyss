inspect = require "lib/inspect"


throw = love.errhand


function values(t)
  local i = 0
  return function() i = i + 1; return t[i] end
end


function enum(tbl)
  local length = #tbl
  for i = 1, length do
      local v = tbl[i]
      tbl[v] = i
  end

  return tbl
end


function copy(obj, seen)
    if type(obj) ~= 'table' then return obj end
    if seen and seen[obj] then return seen[obj] end
    local s = seen or {}
    local res = setmetatable({}, getmetatable(obj))
    s[obj] = res
    for k, v in pairs(obj) do res[copy(k, s)] = copy(v, s) end
    return res
end


function transfer(from, to)
  if type(from) ~= 'table' then return from end
  local s = {}
  s[from] = to
  for k, v in pairs(from) do to[copy(k, s)] = copy(v, s) end
end

--- @param theta number angle to normalize in rad
function normalize_angle(theta)
  return theta - 2 * math.pi * math.floor((theta + math.pi) / (2 * math.pi))
end

--- @param theta number angle to clamp in rad
--- @param min number minimum angle in rad
--- @param max number maximum angle in rad
function clamp_angle(theta, min, max)

  theta = normalize_angle(theta)
  if (theta > max) then return max end
  if (theta < min) then return min end
  return theta
end

-- function class(...)
--     -- "cls" is the new class
--     local cls, bases = {}, {...}
--     local mt = {}
--     -- copy base class contents into the new class
--     for i, base in ipairs(bases) do
--       for k, v in pairs(base) do
--         cls[k] = v
--       end
--     end
--     -- set the class's __index, and start filling an "is_a" table that contains this class and all of its bases
--     -- so you can do an "instance of" check using my_instance.is_a[MyClass]
--     cls.__index, cls.is_a = cls, {[cls] = true}
--     for i, base in ipairs(bases) do
--       for c in pairs(base.is_a) do
--         cls.is_a[c] = true
--       end
--       cls.is_a[base] = true
--     end
--     -- the class's __call metamethod
--     mt.__call = function (c, ...)
--       local instance = setmetatable({}, c)
--       -- run the init method if it's there
--       local init = instance.init
--       if init then init(instance, ...) end
--       return instance
--     end
--     setmetatable(cls, mt)
--     -- return the new class table, that's ready to fill with methods
--     return cls
--   end


function getWords (s, separator)
    separator = separator or "%s"

    local words={}

    for w in string.gmatch(s, "([^"..separator.."]+)") do
            table.insert(words, w)
    end

    return words
end


function length(x, y)

    return math.sqrt(x * x + y * y)
end


function normalize(x, y)

  local l = length(x, y)
  return x / l, y / l
end


function dump(o)
  if type(o) == 'table' then
     local s = '{ '
     for k,v in pairs(o) do
        if type(k) ~= 'number' then k = '"'..k..'"' end
        s = s .. '['..k..'] = ' .. dump(v) .. ','
     end
     return s .. '} '
  else
     return tostring(o)
  end
end

function math.clamp(n, low, high) 
  return math.min(math.max(n, low), high) 
end

function bool_to_number(value)

  return value and 1 or 0
end

function bool_to_inv_number(value)

  return value and 0 or 1
end

function sign(n)

  return n >= 0 and 1 or -1
end


function loop_index(index, size)

    if size >= 0 then
        return (index - 1) % size + 1
    end
    return 0
end