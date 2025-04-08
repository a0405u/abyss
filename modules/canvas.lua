local canvas = {}

canvas.screen = {
    main = love.graphics.newCanvas(screen.width, screen.height),
    window = love.graphics.newCanvas(screen.width, screen.height),
    camera = love.graphics.newCanvas(screen.width, screen.height),
}


function canvas.set(canvas)
    love.graphics.setCanvas(canvas)
end


function canvas.reset()
    
    love.graphics.setCanvas()
end


function canvas.clear(c)

    c = c or color.black
    love.graphics.clear(c)
end


return canvas