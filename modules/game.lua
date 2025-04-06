local game = {}


function game.load()
    
    game.state = "intro"
    game.paused = true

    game.world = love.physics.newWorld(0.0, -GRAVITY)
    game.world:setCallbacks(game.beginContact, game.endContact, game.preSolve, game.postSolve)
    game.map = Map()

    game.player = Actor(Vector2(game.map.size.x / 2, 8))
end


function game.spawn_building(position)
    local building = Building(position)
    game.map:add(building)
    ui.mouse.building = building
end


function game.beginContact(a, b, contact)

    if a:getCategory() == PC_PLANK and b:getCategory() == PC_PLAYER_AREA then

        -- b:getBody():getUserData():presolve(a, b, contact)
        return
    end
    if a:getCategory() == PC_PLAYER_FLOOR_BOX then

        game.player:begincontact(b, contact)
        return
    end
    if b:getCategory() == PC_PLAYER_FLOOR_BOX then

        game.player:begincontact(a, contact)
        return
    end
end

function game.endContact(a, b, contact)

    if a:getCategory() == PC_PLANK and b:getCategory() == PC_PLAYER_AREA then

        a:getBody():getUserData():endcontact(a, b, contact)
        return
    end
    if a:getCategory() == PC_PLAYER_FLOOR_BOX then

        game.player:endcontact(b, contact)
        return
    end
    if b:getCategory() == PC_PLAYER_FLOOR_BOX then

        game.player:endcontact(a, contact)
        return
    end
end

function game.preSolve(a, b, contact)

    if a:getCategory() == PC_PLAYER and b:getCategory() == PC_PLANK then

        b:getBody():getUserData():presolve(a, b, contact)
        return
    end
end

function game.postSolve(a, b, contact, normalimpulse, tangentimpulse)

    local cache = {
        position = contact:getPositions()
    }

    if a:getCategory() == PC_PLANK then
        a:getBody():getUserData():postsolve(a, b, cache, normalimpulse, tangentimpulse)
        return
    end

    if b:getCategory() == PC_PLANK then
        b:getBody():getUserData():postsolve(a, b, cache, normalimpulse, tangentimpulse)
        return
    end
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

    game.map:draw()
    game.player:draw()
    ui:draw()
end


function game.death()

    game.state = "death"
    screen.show("death")
end


return game