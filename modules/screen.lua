local screen = {
    map = {},
    game = {},
    death = {},
    editor = {},
}


function screen.load()

    screen.width = config.screen.width
    screen.height = config.screen.height
    screen.scale = config.screen.scale

    love.window.setTitle(config.screen.title)
    love.window.setMode(screen.width * screen.scale, screen.height * screen.scale, {borderless = config.screen.borderless})

    love.graphics.setDefaultFilter(config.screen.filtermode, config.screen.filtermode)
    love.graphics.setLineStyle(config.screen.linestyle)
    love.mouse.setVisible(config.screen.os_mouse_visibility)
end


function screen.draw()

    -- ПЕРЕХОД МЕЖДУ ЭКРАНАМИ В ВИДЕ ЧЕРНОГО КАДРА
    -- if screen.time <= 0.1 then
    --     return
    -- end

    -- screen[screen.state].draw() -- Запуск функции соответствующей состоянию экрана

    game.draw()

    if config.screen.scanlines == true then
        screen.scanlines()
    end

    if config.screen.fps == true then
        screen.fps()
    end
end


function screen.update(dt)
    screen.time = screen.time + dt

    if screen.state == "intro" and screen.time > 8 then
        game.logo()
    end

    if screen.state == "logo" and screen.time > 3 then
        game.title()
    end
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


function screen.game.draw()

    screen.setCanvas(canvas.screen.main)
    love.graphics.clear(color.black)

    color.reset()

    game.map.draw()
    -- ui.draw()
    -- cursor.draw()
    mouse:draw()

    deep.execute()
end


function screen.show(state)

    screen.state = state
    screen.time = 0

    audio.play(sound.screen)
end


return screen