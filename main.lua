require "headers"

function love.load()

    love.physics.setMeter(config.physics.scale)
    sound.load()
    game:load()
    canvas.load()

    if not DEBUG then
        audio.play(sound.logo)
    end

    if DEBUG then
        game:start()
    end
end


function love.draw()

    screen.reset()

    love.graphics.clear(color.black)
    
    screen.draw()
    debug.draw()

    love.graphics.setCanvas()
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(canvas.screen.main, 0, 0, 0, screen.scale, screen.scale)

end


function love.update(dt)

    input.update(dt)

    if not game.paused then
        game:update(dt)
    end

    screen.update(dt)
    -- ui.update(dt)
end