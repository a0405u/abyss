local game = {}


function game.load()
    
    game.state = "intro"
    game.paused = true

    game.world = love.physics.newWorld(0.0, -GRAVITY)
    game.map = Map()

    game.player = Actor(Vector2(game.map.size.x / 2, 8))
end


function game.start()

    game.state = "game"
    game.paused = false
    screen.show("game")
    
    audio.stop(sound.intro)
    -- audio.play(sound.start)
end


function game.update(dt)
    game.world:update(dt)
    game.map:update(dt)
    game.player:update(dt)
    ui:update(dt)
end


function game.draw()

    screen.setCanvas(canvas.screen.main)
    love.graphics.clear(color.black)

    game.map:draw()

    color.reset()
    game.player:draw()

    -- palette:draw()
    ui:draw()
end


function game.death()

    game.state = "death"
    screen.show("death")
end


return game