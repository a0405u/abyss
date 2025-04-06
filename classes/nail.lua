--- @class Nail: Object
local Nail = class("Nail", Object)

function Nail:init(position, a, b, fixed)

    self.position = position or Vector2()
    self.sprite = sprites.nail
    self.objects = {
        a = a,
        b = b
    }
    if a.nails then a.nails[self] = self end
    if b.nails then b.nails[self] = self end
    self.strength = 8000
    self.fixed = (fixed ~= false)

    if not self.fixed then
        self.joint = love.physics.newRevoluteJoint(self.objects.a.body, self.objects.b.body, self.position.x, self.position.y, false)
    else
        self.joint = love.physics.newWeldJoint(self.objects.a.body, self.objects.b.body, self.position.x, self.position.y, false)
    end
end


function Nail:destroy()
    self.joint:destroy()
    if self.objects.a.nails then self.objects.a.nails[self] = nil end
    if self.objects.b.nails then self.objects.b.nails[self] = nil end
    self.parent:remove(self)
end


function Nail:update(dt)

    if not self.fixed and Vector2(self.joint:getReactionForce(1/dt)):length() > self.strength then
        self:destroy()
    end
    -- print(self.joint:getAnchors())
end


function Nail:draw()

    local position = game.map:get_draw_position(self.position)
    -- color.set(color.red)
    -- love.graphics.points(position.x, position.y)
    self.sprite:draw(DL_NAIL, position)
end


return Nail
