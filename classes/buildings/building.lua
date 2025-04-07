--- @class Building
local Building = class("Building", Object)


function Building:init(position, rotation, sprite, colliders)

    self.position = position or Vector2()
    self.rotation = rotation or 0.0
    self.sprite = sprite:instantiate() or sprites.building:instantiate()
    self.colliders = colliders or sprite.data.slices
    print(self.colliders[1].keys[1].bounds)
    self.ghost = true
    self.body = love.physics.newBody(game.world, self.position.x, self.position.y, "dynamic")

    self.sprite:set(self.sprite.animations.ghost)
end


function Building:destroy()

end


function Building:set_position(position)

    self.position = position
    self.body:setPosition(self.position.x, self.position.y)
end


function Building:place(position)

    if position then self.body:setPosition(position.x, position.y) end

    for i, collider in ipairs(self.colliders) do
        local bounds = collider.keys[1].bounds
        bounds.x, bounds.y = bounds.x / game.map.scale, bounds.y / game.map.scale
        bounds.w, bounds.h = bounds.w / game.map.scale, bounds.h / game.map.scale
        self.fixture = love.physics.newFixture(self.body, love.physics.newRectangleShape(0, bounds.h / 2, bounds.w, bounds.h), DS_BUILDING)
        self.fixture:setCategory(PC_BUILDING)
        self.fixture:setMask(PC_PLAYER)
    end
    self.ghost = false
    self.sprite:set(self.sprite.animations.idle)
    self.body:setActive(true)
end


function Building:update(dt)

    if self.ghost then
        return
    end
    self.position.x, self.position.y = self.body:getPosition()
    self.rotation = self.body:getAngle()
end


function Building:draw()

    color.reset()
    local position = game.map:get_draw_position(self.position)
    -- local c = color.white
    -- local a = (self.ghost and 0.4) or 1
    self.sprite:draw(DL_BUILDING, position, -self.rotation, nil, nil, c, a)
end


return Building
