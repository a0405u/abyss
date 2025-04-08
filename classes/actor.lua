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
    self.on_floor = false
    self.acceleration = args.acceleration or 18
    self.max_speed = args.max_speed or 16
    self.friction = args.friction or 64
    self.normal = Vector2()
    self.look_direction = 1
    self.jump_impulse = JUMP * self.mass
    self.health = args.health or 3
    self.range = 8
    self.floor_count = 0

    self.body = love.physics.newBody(game.world, self.position.x, self.position.y, "dynamic")
    self.fixture = love.physics.newFixture(self.body, love.physics.newRectangleShape(0, self.size.y / 2, self.size.x, self.size.y), 26)
    self.fixture:setCategory(PC_PLAYER)
    self.area = love.physics.newFixture(self.body, love.physics.newCircleShape(0, self.size.y / 2, self.range), 0)
    self.area:setCategory(PC_PLAYER_AREA)
    self.area:setSensor(true)
    self.floor_box = love.physics.newFixture(self.body, love.physics.newRectangleShape(self.size.x - self.size.x / 4, 1), 0)
    self.floor_box:setCategory(PC_PLAYER_FLOOR_BOX)
    self.floor_box:setSensor(true)
    self.body:setMass(self.mass)
    self.body:setFixedRotation(true)

    self.sprite.animation:play()

    self.sphere = {
        last = -1,
        show = function(radius)
            self.sphere.last = love.timer.getTime()
            self.sphere.radius = radius or self.range
        end,
        draw = function(position)
            local time = love.timer.getTime()
            local delta = time - self.sphere.last
            local a = 1 - delta
            
            if a > 0 then
                screen.layer:queue(DL_PLAYER, function ()
                    color.set(color.darkest, a)
                    love.graphics.circle("line", position.x, position.y, game.player.sphere.radius * game.map.scale)
                    color.reset()
                end)
            end
        end
    }
end


function Actor:update(dt)

    self.sprite:update(dt)
    self:update_direction(dt)
    self:move(dt)
end


function Actor:draw()

    local position = game.map:get_draw_position(self.position)
    local size = game.map:get_scaled_vector(self.size)

    -- love.graphics.points(position.x, position.y)
    -- love.graphics.circle("fill", position.x, position.y, 1)
    -- love.graphics.rectangle("fill", position.x - size.x / 2, position.y - size.y / 2, size.x, size.y)
    self.sprite:draw(DL_PLAYER, position)
    self.sphere.draw(position)
end


function Actor:in_range(position, range)

    range = range or self.range
    if Vector2(self.position.x - position.x, self.position.y - position.y):length() > range then
        return false
    end
    return true
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
            self.sprite:set(self.sprite.animations.run)
            self.sprite.animation:play()
        end
    else
        if self.direction == 0 then
            self.moving = false
            self.sprite:set(self.sprite.animations.idle)
            self.sprite.animation:play()
        end
    end
end


function Actor:land()
    audio.play(sound.land)
    if self.moving == true then
        self.sprite:set(self.sprite.animations.run)
        self.sprite.animation:play()
    else
        self.sprite:set(self.sprite.animations.idle)
        self.sprite.animation:play()
    end
end


function Actor:move(dt)

    local velocity = Vector2(self.body:getLinearVelocity())
    local normal = velocity:normalized()
    local acceleration = self.direction * self.acceleration
    local friction = 0.0

    if self:is_on_floor() and velocity.y <= 1 then
        if not self.on_floor then
            self.on_floor = true
            self:land()
        end
        if not self.moving then
            friction = normal.x * self.friction
        end
    else
        self.on_floor = false
        if normal.y < 0 then
            self.sprite:set(self.sprite.animations.fall)
            self.sprite.animation:play()
        else
            self.sprite:set(self.sprite.animations.jump)
            self.sprite.animation:play()
        end
    end

    velocity.x = math.clamp(velocity.x, -self.max_speed, self.max_speed)
    velocity.y = math.clamp(velocity.y, -self.max_speed * 4, self.max_speed * 4)
    self.body:setLinearVelocity(velocity.x, velocity.y)

    self.body:applyLinearImpulse((acceleration - friction) * self.mass * dt, 0)

    self.position = Vector2(self.body:getPosition())
    self.direction = 0
end


function Actor:jump()

    local velocity = Vector2(self.body:getLinearVelocity())
    if self:is_on_floor() and velocity.y <= 1 then
        audio.play(sound.jump)
        --self.velocity.y = self.velocity.y + self.jump_velocity
        self.body:applyLinearImpulse(0, self.jump_impulse)
    end
end


function Actor:begincontact(a, b, contact)
    
    self.floor_count = math.max(0, self.floor_count + 1)
end


function Actor:endcontact(a, b, contact)

    self.floor_count = math.max(0, self.floor_count - 1)
end


function Actor:is_on_floor()

    return self.floor_count > 0
end

return Actor
