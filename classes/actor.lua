--- @class Actor
--- @field name string|nil
--- @field sprite Sprite
--- @field position Vector2
--- @field velocity Vector2
--- @field direction number
--- @field look_direction number
--- @field health number
--- @field acceleration number
--- @field friction number
local Actor = class("Actor", Object)


function Actor:init(position, name, sprite, args)
    if not args then args = {} end

    self.name = name or nil
    self.sprite = sprites.player:instantiate()
    self.mass = 70
    self.position = position or Vector2()
    self.size = Vector2(1.5, 1.75)
    self.direction = 0.0
    self.moving = false
    self.acceleration = args.acceleration or 18
    self.max_speed = args.max_speed or 8
    self.friction = args.friction or 32
    self.normal = Vector2()
    self.look_direction = 1
    self.jump_impulse = 8 * self.mass
    self.health = args.health or 3
    self.range = 8

    self.body = love.physics.newBody(game.world, self.position.x, self.position.y, "dynamic")
    self.fixture = love.physics.newFixture(self.body, love.physics.newRectangleShape(0, self.size.y / 2, self.size.x, self.size.y), 26)
    self.fixture:setCategory(PC_PLAYER)
    self.area = love.physics.newFixture(self.body, love.physics.newCircleShape(0, self.size.y / 2, self.range), 0)
    self.area:setCategory(PC_PLAYER_AREA)
    self.area:setSensor(true)
    self.body:setMass(self.mass)
    self.body:setFixedRotation(true)

    self.sprite.animation:play()
end


function Actor:update(dt)

    self.sprite:update(dt)
    self:update_direction(dt)
    self:move(dt)
end


function Actor:in_range(position, range)

    range = range or self.range
    if Vector2(self.position.x - position.x, self.position.y - position.y):length() > range then
        return false
    end
    return true
end


function Actor:draw()

    local position = game.map:get_draw_position(self.position)
    local size = game.map:get_scaled_vector(self.size)

    -- love.graphics.points(position.x, position.y)
    -- love.graphics.circle("fill", position.x, position.y, 1)
    -- love.graphics.rectangle("fill", position.x - size.x / 2, position.y - size.y / 2, size.x, size.y)
    self.sprite:draw(DL_PLAYER, position)
end


function Actor:set_direction(direction)

    self.direction = direction
    self.look_direction = direction
    self.sprite.scale = Vector2(self.look_direction, 1)
end


function Actor:update_direction(dt)
    if self.moving == false then
        if self.direction ~= 0 then
            self.moving = true
            self.sprite.animation = self.sprite.animations.run
            self.sprite.animation:play()
        end
    else
        if self.direction == 0 then
            self.moving = false
            self.sprite.animation = self.sprite.animations.idle
            self.sprite.animation:play()
        end
    end
end


function Actor:move(dt)

    local normal = Vector2(self.body:getLinearVelocity()):normalized()
    local acceleration = self.direction * self.acceleration
    local friction = 0.0

    if self:is_on_floor() and not self.moving then
        friction = normal.x * self.friction
    end

    self.body:applyLinearImpulse((acceleration - friction) * self.mass * dt, 0)

    -- self.velocity.x = math.clamp(self.velocity.x, -self.max_speed, self.max_speed)

    self.position = Vector2(self.body:getPosition())
    self.direction = 0
end


function Actor:jump()

    if self:is_on_floor() then
        --self.velocity.y = self.velocity.y + self.jump_velocity
        self.body:applyLinearImpulse(0, self.jump_impulse)
    end
end


function Actor:is_on_floor()

    local contacts = self.body:getContacts()

    for i, contact in ipairs(contacts) do

        local x, y = contact:getPositions()
        local nx, ny = contact:getNormal()
        if ny > 0.5 or ny < -0.5 and self.position.y > y then
            return true
        end
    end
    return false
end

return Actor
