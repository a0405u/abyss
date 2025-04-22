local debug = {}
debug.variables = {}

function debug.draw()

    s = ""

    for i, n in ipairs(debug.variables) do
        s = s .. n .. ": " .. debug.variables[n] .. "\n"
    end

    love.graphics.printf(s, font.small, 0, 8, screen.size.y, "right")
end


function debug.add(name, value)

    table.insert(debug.variables, name)
    debug.variables[name] = value
end


function debug.update(name, value)

    debug.variables[name] = value
end


function debug.list(table)

    print("Listing ",  table)
    for key, value in pairs(table) do
        print(key, value)
    end
end


return debug