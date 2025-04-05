local color = {}


function color.load(palette)

    data = love.image.newImageData(palette)

    for y = 0, data:getHeight() - 1 do
        for x = 0, data:getWidth() - 1 do
            local r, g, b = data:getPixel(x, y)
            table.insert(color, {r, g, b})
        end
    end

    color.black = color[1]
    color.white = color[3]
    color.light = color[2]
    color.red = color[4]
    color.lightest = color[19]
    color.dark = color[18]
    color.darkest = color[13]
    color.blue = color[29]
    color.lightblue = color[15]
    color.purple = color[30]
    color.brightyellow = color[9]
    color.yellow = color[25]
    color.green = color[11]
    color.pink = color[31]
    color.skin = color[32]
    color.transparent = {0, 0, 0, 0}
end


function color.theme(name)

    if name == "day" then
        color.lightest = {244/255, 244/255, 244/255}
        color.light = {177/255, 177/255, 177/255}
        color.dark = {138/255, 138/255, 138/255, 1}
        color.darkest = {51/255, 51/255, 51/255, 1}
        return
    end

    if name == "night" then
		color.lightest = {244/255, 244/255, 244/255}
		color.light = {177/255, 177/255, 177/255}
        color.dark = {91/255, 91/255, 91/255, 1}
        color.darkest = {21/255, 21/255, 21/255, 1}
        return
    end
end


function color.reset()

    love.graphics.setColor(1, 1, 1, 1)
end


function color.set(c, a)

	c[4] = a
    love.graphics.setColor(c)
end


function color.id(c)

    for i, v in ipairs(color) do
        if v == c then
            return i
        end
    end
    -- return 1
end 


function hsv(h, s, v)
    if s <= 0 then return v,v,v end
    h, s, v = h/256*6, s/255, v/255
    local c = v*s
    local x = (1-math.abs((h%2)-1))*c
    local m,r,g,b = (v-c), 0,0,0
    if h < 1     then r,g,b = c,x,0
    elseif h < 2 then r,g,b = x,c,0
    elseif h < 3 then r,g,b = 0,c,x
    elseif h < 4 then r,g,b = 0,x,c
    elseif h < 5 then r,g,b = x,0,c
    else              r,g,b = c,0,x
    end return (r+m), (g+m), (b+m)
end


function hex(value, a)
    hexVal = string.sub(value, 2)
    hexVal = string.upper(hexVal)
    if #hexVal == 3 then
      f = hexVal:sub(1,1)
      s = hexVal:sub(2,2)
      t = hexVal:sub(3,3)
      hexVal = f..f..s..s..t..t
    end
    val = {}
  
    for i=1, #hexVal do
      char = hexVal:sub(i, i)
      if char == "0" then
        val[i] = tonumber(char)+1
      elseif char == "1" then
        val[i] = tonumber(char)+1
      elseif char == "2" then
        val[i] = tonumber(char)+1
      elseif char == "3" then
        val[i] = tonumber(char)+1
      elseif char == "4" then
        val[i] = tonumber(char)+1
      elseif char == "5" then
        val[i] = tonumber(char)+1
      elseif char == "6" then
        val[i] = tonumber(char)+1
      elseif char == "7" then
        val[i] = tonumber(char)+1
      elseif char == "8" then
        val[i] = tonumber(char)+1
      elseif char == "9" then
        val[i] = tonumber(char)+1
      elseif char == "A" then
        val[i] = 11
      elseif char == "B" then
        val[i] = 12
      elseif char == "C" then
        val[i] = 13
      elseif char == "D" then
        val[i] = 14
      elseif char == "E" then
        val[i] = 15
      elseif char == "F" then
        val[i] = 16
      end
    end
  
    r = r or 255
    g = g or 255
    b = b or 255
    a = a or 255
    r = val[1] * 16 + val[2]
    g = val[3] * 16 + val[4]
    b = val[5] * 16 + val[6]
  
    return {r/255, g/255, b/255, a}
end


function rgb(r, g, b)
    r = r or 255
    g = g or 255
    b = b or 255
    return {r/255, g/255, b/255}
end


function rgba(r, g, b, a)
    r = r or 255
    g = g or 255
    b = b or 255
    a = a or 1
    return {r/255, g/255, b/255, a}
end


return color