require "lib/support"

local balls = {}
local time = 0.0
local ltime = 0.0
local dtime = 0.00001
local vw = 128
local vh = 128
local s = 4
local c = love.graphics.newCanvas(vw, vh)


local Ball = class()


function Ball:init(x, y, vx, vy)
    
    self.x = x
    self.y = y
    self.vx = vx
    self.vy = vy
end


function Ball:update(dt)

    self.x = self.x + self.vx * dt
    self.y = self.y + self.vy * dt

    if self.x < 0 or self.x > vw then self.vx = self.vx * -1 end
    if self.y < 0 or self.y > vh then self.vy = self.vy * -1 end
end


function Ball:draw()

    love.graphics.points(self.x, self.y)
end


local VectorBall = class()


function VectorBall:init(position, velocity)
    
    self.position = position
    self.velocity = velocity
end


function VectorBall:update(dt)

    self.position.x = self.position.x + self.velocity.x * dt
    self.position.y = self.position.y + self.velocity.y * dt

    if self.position.x < 0 or self.position.x > vw then self.velocity.x = self.velocity.x * -1 end
    if self.position.y < 0 or self.position.y > vh then self.velocity.y = self.velocity.y * -1 end
end


function VectorBall:draw()

    love.graphics.points(self.position.x, self.position.y)
end


function love.load()

    love.window.setMode(vw * s, vh * s)

    love.graphics.setDefaultFilter("nearest", "nearest")
    love.graphics.setLineStyle("rough")
    love.mouse.setVisible(false)
end



function love.draw()

    love.graphics.setCanvas(c)
    love.graphics.clear(0, 0, 0)
    
    for i, ball in ipairs(balls) do
        ball:draw()
    end

    love.graphics.setCanvas()
    love.graphics.draw(c, 0, 0, 0, s, s)
end


function love.update(dt)

    if dt >= 0.1 then
        love.update = nil
    end

    time = time + dt

    if time > ltime + dtime then
        for i = 1, (time - ltime) / dtime do
            table.insert(balls, Ball(love.math.random() * vw, love.math.random() * vh, love.math.random(-1.0, 1.0), love.math.random(-1.0, 1.0)))
            -- table.insert(balls, VectorBall({x = love.math.random() * vw, y = love.math.random() * vh}, {x = love.math.random(-1.0, 1.0), y = love.math.random(-1.0, 1.0)}))
        end
        ltime = time
    end

    for i, ball in ipairs(balls) do
        ball:update(dt)
    end

    print(string.format("count: %d, delay: %f", #balls, dt))
end