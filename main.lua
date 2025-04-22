require "headers"

function love.load(args)

    if args then
        for i, arg in ipairs(args) do
            if arg == "-d" then DEBUG = true end
        end
    end

    config:load()
    love.physics.setMeter(config.physics.scale)
    input.load()
    color.load(config.theme.palette)
    screen.load()
    window = Window(screen.size * screen.scale)
    canvas.load()
    audio.load()
    sound.load()
    sprites.load()
    ui.load()
    game:load()

    if not DEBUG then
        love.audio.setVolume(config.audio.volume / 4)
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
    love.graphics.draw(canvas.screen.main, screen.position.x, screen.position.y, 0, screen.scale, screen.scale)

end


function love.update(dt)

    input.update(dt)

    if dt < 1 and not game.paused then
        game:update(dt)
    end

    screen.update(dt)
    -- ui.update(dt)
end