local canvas = {}

function canvas.load()

    canvas.screen = {
        main = love.graphics.newCanvas(screen.size.x, screen.size.y),
        window = love.graphics.newCanvas(screen.size.x, screen.size.y),
        camera = love.graphics.newCanvas(screen.size.x, screen.size.y),
    }
end


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