--- @class Nail
local Nail = class("Nail", Object)

--- @param a love.Body
--- @param b love.Body
function Nail:init(position, a, b, allow_rotation)

    self.position = position or Vector2()
    self.body = {
        a = a,
        b = b
    }
    self.allow_rotation = (allow_rotation ~= false)
    if allow_rotation then
        self.joint = love.physics.newRevoluteJoint(a, b, self.position.x, self.position.y, false)
    else
        self.joint = love.physics.newWeldJoint(a, b, self.position.x, self.position.y, false)
    end
end


function Nail:update(dt)

    -- print(self.joint:getAnchors())
end


function Nail:draw()

    local position = game.map:get_draw_position(self.position)
    color.set(color.red)
    love.graphics.points(position.x, position.y)
end


return Nail
