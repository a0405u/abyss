local input = {}

love.keyboard.setKeyRepeat(true)

input.keydown = love.keyboard.isDown

function love.keypressed(key, scancode, isrepeat)

    if key == config.input.back then
        love.event.quit()
    end

    if key == config.input.b then
        game.cannon:fire()
    end

    if key == config.input.select then
        game.player:jump()
    end

    if key == config.input.one then
        if not ui.mouse.building then
            game.spawn_building(ui.mouse.position.map)
        end
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