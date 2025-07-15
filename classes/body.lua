--- @class Body : Drawable
local Body = class("Body", Drawable)


function Body:init(position, rotation, sprite, dl, type)

    Drawable.init(self, position, rotation, sprite, dl)

    self.body = love.physics.newBody(game.world, self.position.x, self.position.y, type or "dynamic")
    self.body:setUserData(self)
    self.body:setAngle(self.rotation)
    self.dimpulse = 0.0
end


function Body:begincontact(a, b, contact) return end


function Body:endcontact(a, b, contact) return end


function Body:presolve(a, b, contact) return end

--- comment
--- @param a love.Fixture
--- @param b love.Fixture
--- @param contact table
--- @param normalimpulse table
--- @param tangentimpulse table
function Body:postsolve(a, b, contact, normalimpulse, tangentimpulse)
    
    local impulse = normalimpulse[1] + normalimpulse[2] + math.abs(tangentimpulse[1] + tangentimpulse[2])
    self.dimpulse = math.max(self.dimpulse, impulse)
end


return Body
