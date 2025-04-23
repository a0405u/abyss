local screen = {
    logo = {},
    game = {},
    death = {},
    editor = {},
    ending = {}
}

function screen.load()

    screen.size = Vector(config.screen.width, config.screen.height)
    screen.scale = config.screen.scale
    screen.state = screen.logo
    screen.position = Vector()

    love.graphics.setDefaultFilter(config.screen.filtermode, config.screen.filtermode)
    love.graphics.setLineStyle(config.screen.linestyle)
    love.mouse.setVisible(config.screen.os_mouse_visibility)

    screen.time = 0
    screen.layer = deep:new()
end


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

    love.graphics.setCanvas(canvas.screen.main)
    -- love.graphics.setBlendMode("alpha")
    color.reset()
end


function screen.zoom(amount)
    screen.scale = screen.scale + amount
    window:set_mode(screen.size * screen.scale)
    screen.position = screen.calculate_position()
end


function screen.set_scale(scale)

    screen.scale = scale
    window:set_mode(screen.size * screen.scale)
    screen.position = screen.calculate_position()
end


function screen.switch_fullscreen()
    local fullscreen = not love.window.getFullscreen()
    if fullscreen then
        local x, y = love.window.getDesktopDimensions()
        screen.scale = math.floor(math.min(x / screen.size.x, y / screen.size.y))
    else
        screen.scale = config.screen.scale
    end
    window:set_mode(screen.size * screen.scale, fullscreen)
    screen.position = screen.calculate_position()
end


function screen.calculate_position()

    return Vector((window.size.x - screen.size.x * screen.scale) / 2, (window.size.y - screen.size.y * screen.scale) / 2)
end


function screen.setCanvas(canvas)

    love.graphics.setCanvas(canvas)
    -- love.graphics.setBlendMode("alpha")
    color.reset()
end


function screen.fps()

    love.graphics.setColor(color.black)
    love.graphics.rectangle("fill", screen.size.x - 9, 0, 9, 7)

    love.graphics.setColor(color.white)
    love.graphics.printf(love.timer.getFPS(), font.small, 0, 0, screen.size.x, "right")
end


function screen.logo.draw()

    sprites.screen.logo:draw(DL_UI, Vector(screen.size.x / 2, screen.size.y / 2))
    if screen.time > 3 then
        screen.state = screen.game
        game:start()
    end
end


function screen.game.draw()

    game:draw()
end

function screen.ending.draw()
    ui.print("You managed to get out.", Vector(0, screen.size.y / 2), screen.size.x, "center")
end


function screen.show(state)

    screen.state = state
    screen.time = 0

    audio.play(sound.screen)
end


return screen