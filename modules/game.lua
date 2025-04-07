local game = {}


function game:load()
    
    self.state = "intro"
    self.paused = true

    self.world = love.physics.newWorld(0.0, -GRAVITY)
    self.world:setCallbacks(beginContact, endContact, preSolve, postSolve)
    self.map = Map()

    self.player = Actor(Vector2(game.map.size.x / 6, 2))
    self.economy = Economy()

    self.tools = {
        plank = ToolPlank(),
        block = ToolBlock(),
        soil = ToolSoil(),
    }
    self.tool = self.tools.plank
    ui.left.buttons.plank:activate()

    self.map.tilemap:add_hill(Vector2(8, 1))
end


function game:set_tool(tool)

    self.tool = tool
end


function game:activate(position)

    if self.tool then self.tool:use(position) end
end


function game:build_plank(position)

    if self.economy:has(COST_PLANK) then
        self.economy:take(COST_PLANK)
        local plank = Plank(position)
        self.map:add(plank)
        return plank
    end
    return false
end


function game:build_block(block, cost, position)

    local tilemap_position = self.map.tilemap:get_position(position)
    if not self.map.tilemap:is_in_tile(self.player.position, tilemap_position) then
        if self.economy:has(cost) then
            if self.map.tilemap:build(block, tilemap_position) then
                self.economy:take(cost)
            end
        end
    end
end

function game:spawn_building(position)
    local building = Building(position)
    self.map:add(building)
    ui.mouse.building = building
end


function beginContact(a, b, contact)

    if a:getCategory() == PC_PLANK and b:getCategory() == PC_PLAYER_AREA then

        -- b:getBody():getUserData():presolve(a, b, contact)
        return
    end
    if a:getCategory() == PC_PLAYER_FLOOR_BOX then

        game.player:begincontact(a, b, contact)
    end
    if b:getCategory() == PC_PLAYER_FLOOR_BOX then

        game.player:begincontact(a, b, contact)
    end
end

function endContact(a, b, contact)

    if a:getCategory() == PC_PLANK and b:getCategory() == PC_PLAYER_AREA then

        a:getBody():getUserData():endcontact(a, b, contact)
        return
    end
    if a:getCategory() == PC_PLAYER_FLOOR_BOX then

        game.player:endcontact(a, b, contact)
    end
    if b:getCategory() == PC_PLAYER_FLOOR_BOX then

        game.player:endcontact(b, a, contact)
    end
end

function preSolve(a, b, contact)

    if b:getCategory() == PC_PLANK then
        b:getBody():getUserData():presolve(b, a, contact)
        return
    end
end

function postSolve(a, b, contact, normalimpulse, tangentimpulse)

    local cache = {
        position = contact:getPositions()
    }

    if a:getCategory() == PC_PLANK then
        a:getBody():getUserData():postsolve(a, b, cache, normalimpulse, tangentimpulse)
    end

    if b:getCategory() == PC_PLANK then
        b:getBody():getUserData():postsolve(b, a, cache, normalimpulse, tangentimpulse)
    end
end


function game:start()

    self.state = "game"
    self.paused = false
    screen.show(screen.game)
    
    audio.stop(sound.logo)
    -- audio.play(sound.start)
end


function game:update(dt)
    self.world:update(dt)
    self.map:update(dt)
    self.player:update(dt)
    self.economy:update(dt)
    self.tool:update(dt)
    ui:update(dt)
end


function game:draw()

    self.map:draw()
    self.player:draw()
    self.tool:draw()
    ui:draw()
end


function game:death()

    self.state = "death"
    screen.show(screen.death)
end


return game