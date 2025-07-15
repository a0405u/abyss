--- @class Game
--- @field map Map
local game = {}


function game:load()

    self.state = "intro"
    self.paused = true

    self.world = love.physics.newWorld(0.0, -GRAVITY)
    self.world:setCallbacks(beginContact, endContact, preSolve, postSolve)
    self.map = Map()
    self.player = Actor(Vector(self.map.size.x / 6, DEBUG and 2 or self.map.size.y))
    self.camera = Camera(self.player.position)
    self.economy = Economy()

    self.tools = {
        plank = ToolPlank(),
        tile = ToolTile(),
        building = ToolBuilding(),
        hammer = ToolHammer()
    }
    self.tool = self.tools.plank
    self.hand = ToolHand()
    self.map.tilemap:add_hill(Vector(16, 1))
    self.timer = Timer()
    ui.left.buttons.platform:activate(true)
end


function game:update(dt)

    if self.paused then return end

    self.timer:update(dt)
    self.world:update(dt)
    self.map:update(dt)
    self.player:update(dt)
    self.camera:update(dt)
    self.economy:update(dt)
    self.tool:update(dt)
    self.hand:update(dt)
    ui:update(dt)
    -- if self.player.position.y > self.map.size.y then
    --     game:ending()
    -- end
end


function game:draw()
    love.graphics.clear(color.black)
    self.map:draw()
    self.player:draw()
    self.tool:draw()
    self.hand:draw()
    screen.layer:draw()
    screen.reset()
    ui:draw()
end


function game:set_tool(tool, ...)

    self.tool = tool
    self.tool:activate(...)
    ui.right:set_tool(tool, ...)
end


function game:activate(position)

    if self.tool then self.tool:use(position) end
end


function game:build_block(block, cost, position)

    local tilemap_position = self.map.tilemap:get_position(position)
    if not block.solid or not self.map.tilemap:is_in_tile(self.player.position, tilemap_position) then
        if self.economy:has(cost) then
            if self.map.tilemap:build(block, tilemap_position) then
                self.economy:take(cost)
                return true
            end
        else
            ui.hint:queue("You don't have enough resources!")
        end
    end
    return false
end


function game:spawn_building(position, building)

    building:place(position)
    self.map:add(building)
    return true
end


function beginContact(a, b, contact)

    -- Pass processing to the objects colliding
    a:getBody():getUserData():begincontact(a, b, contact)
    b:getBody():getUserData():begincontact(b, a, contact)
end


function endContact(a, b, contact)

    -- Pass processing to the objects colliding
    a:getBody():getUserData():endcontact(a, b, contact)
    b:getBody():getUserData():endcontact(b, a, contact)
end


function preSolve(a, b, contact)

    -- Pass processing to the objects colliding
    a:getBody():getUserData():presolve(a, b, contact)
    b:getBody():getUserData():presolve(b, a, contact)
end


function postSolve(a, b, contact, ni1, ti1, ni2, ti2)

    local xa, ya, xb, yb = contact:getPositions();
    local normalimpulse = {ni1, ni2 or 0.0}
    local tangentimpulse = {ti1, ti2 or 0.0}

    -- Save contact to cache since it might be destroyed before processed
    local cache = {
        position = Vector(xa, ya),
        secondary = xb and Vector(xb, yb) or nil, -- might be absent
        normal = Vector(contact:getNormal()),
        istouching = contact:isTouching()
    }

    -- Compensate two-point contact impulse (Solved with impulse accumulation)
    -- if(xb or yb) then normalimpulse = normalimpulse * 2 end

    -- if (normalimpulse > 200) then print(normalimpulse) end

    -- Pass processing to the objects colliding
    a:getBody():getUserData():postsolve(a, b, cache, normalimpulse, tangentimpulse)
    b:getBody():getUserData():postsolve(b, a, cache, normalimpulse, tangentimpulse)
end


function game:start()

    love.audio.setVolume(config.audio.volume)
    self.state = "game"
    self.paused = false
    screen.show(screen.game)

    audio.stop(sound.logo)
    ui.hint:queue("You've fallen into the deep abyss, find a way to get out...")
    -- audio.play(sound.start)
end


function game:ending()

    self.state = "ending"
    audio.play(sound.logo)
    screen.show(screen.ending)
    self.paused = true
end


return game