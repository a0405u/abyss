local input = {}

function input.load()

    love.keyboard.setKeyRepeat(config.input.keyrepeat)
    input.keydown = love.keyboard.isDown
end

function love.keypressed(key, scancode, isrepeat)

    if key == config.input.back then
        if DEBUG then love.event.quit() end
    end

    if key == config.input.b then
        game.cannon:fire()
    end

    if key == config.input.select then
        game.player:jump()
    end

    if key == config.input.one then
        
    end

    if key == "r" then
        game:load()
        game:start()
    end

    if key == "-" then
        screen.zoom(-1)
    end

    if key == "=" then
        screen.zoom(1)
    end
end


function love.keyreleased(key)

    if screen.state == screen.game then

        return
    end
end


function love.textinput(text)

        return
end


function love.mousepressed(x, y, button, istouch, presses)

    ui.mouse:pressed(x, y, button, istouch, presses)
end


function love.mousereleased(x, y, button, istouch, presses)

    ui.mouse:released(x, y, button, istouch, presses)
end


function input.update(dt)

    if screen.state == screen.game then

        if love.keyboard.isDown(config.input.right) then
            game.player:set_direction(1)
        end
    
        if love.keyboard.isDown(config.input.left) then
            game.player:set_direction(-1)
        end
    end
 
end


return input