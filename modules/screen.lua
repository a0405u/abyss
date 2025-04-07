local screen = {
    logo = {},
    game = {},
    death = {},
    editor = {},
}


screen.width = config.screen.width
screen.height = config.screen.height
screen.scale = DEBUG and 2 or config.screen.scale
screen.state = screen.logo

love.window.setTitle(config.screen.title)
love.window.setMode(screen.width * screen.scale, screen.height * screen.scale, {borderless = config.screen.borderless})

love.graphics.setDefaultFilter(config.screen.filtermode, config.screen.filtermode)
love.graphics.setLineStyle(config.screen.linestyle)
love.mouse.setVisible(config.screen.os_mouse_visibility)

love.window.setFullscreen(config.screen.fullscreen)

screen.time = 0
screen.layer = deep:new()


function screen.draw()

    -- ПЕРЕХОД МЕЖДУ ЭКРАНАМИ В ВИДЕ ЧЕРНОГО КАДРА
    -- if screen.time <= 0.1 then
    --     return
    -- end

    screen.state.draw() -- Запуск функции соответствующей состоянию экрана
    screen.layer:draw()

    if config.screen.scanlines == true then
        screen.scanlines()
    end

    if config.screen.fps == true then
        screen.fps()
    end
end


function screen.update(dt)
    screen.time = screen.time + dt
end


function screen.reset()

    love.graphics.setCanvas({canvas.screen.main, stencil = true})
    love.graphics.setBlendMode("alpha")
    color.reset()
end


function screen.setCanvas(canvas)

    love.graphics.setCanvas({canvas, stencil = true})
    love.graphics.setBlendMode("alpha")
    color.reset()
end


function screen.fps()

    love.graphics.setColor(color.black)
    love.graphics.rectangle("fill", screen.width - 9, 0, 9, 7)

    love.graphics.setColor(color.white)
    love.graphics.printf(love.timer.getFPS(), font.small, 0, 0, screen.width, "right")
end


function screen.logo.draw()

    sprites.screen.logo:draw(DL_UI, Vector2(screen.width / 2, screen.height / 2))
    if screen.time > 3 then
        screen.state = screen.game
        game:start()
    end
end


function screen.game.draw()

    game:draw()
end


function screen.show(state)

    screen.state = state
    screen.time = 0

    audio.play(sound.screen)
end


return screen