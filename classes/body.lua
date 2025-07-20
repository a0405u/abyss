--- @class Body : Drawable
local Body = class("Body", Drawable)


function Body:init(position, rotation, sprite, dl, type)

    Drawable.init(self, position, rotation, sprite, dl)

    self.body = love.physics.newBody(game.world, self.position.x, self.position.y, type or "dynamic")
    self.body:setUserData(self)
    self.body:setAngle(self.rotation)
    self.velocity = Vector()
    self.dvelocity = Vector()
    self.durability = DUR_BUILDING
    self.dimpulse = 0.0
end


function Body:update(dt)
    Drawable.update(self, dt)

    self.position.x, self.position.y = self.body:getPosition()
    self.rotation = self.body:getAngle()
end


function Body:collision_sound(s, p)

    local fraction = self.dimpulse / (self.durability * self.body:getMass())
    local volume = math.min(fraction * fraction * 8, 1.0)
    if self.dvelocity:getLength() > 3 then
        audio.play(s, volume, p)
    end
end


function Body:begincontact(a, b, contact) return end


function Body:endcontact(a, b, contact) return end


function Body:presolve(a, b, contact)
    
    self.velocity = Vector(a:getBody():getLinearVelocityFromWorldPoint(contact:getPositions()))
end

--- comment
--- @param a love.Fixture
--- @param b love.Fixture
--- @param contact table
--- @param normalimpulse table
--- @param tangentimpulse table
function Body:postsolve(a, b, contact, normalimpulse, tangentimpulse)
    
    self.dvelocity = self.velocity - Vector(a:getBody():getLinearVelocityFromWorldPoint(contact.position:split()))
    local impulse = normalimpulse[1] + normalimpulse[2] + math.abs(tangentimpulse[1] + tangentimpulse[2])
    self.dimpulse = math.max(self.dimpulse, impulse)
end


return Body
