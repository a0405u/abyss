local Explosion = class("Explosion", Object)

--- @class Explosion
function Explosion:init(position, size, parent)

    Explosion.super:init(parent)
    self.position = position or Vector2()
    self.sprite = sprites.explosion:instantiate(self)
    self.sprite.animation.on_loop = function () self:on_animation_end() end

    self.sprite.animation:play()
end


function Explosion:update(dt)

    self.sprite:update(dt)
end


function Explosion:draw()

    color.reset()
    local positon = game.map:get_position(self.position.x, self.position.y, self.position.z)
    self.sprite:draw(positon)
    -- love.graphics.circle("fill",positon.x, positon.y, 4)
end


function Explosion:on_animation_end()

    self.parent:remove(self)
end


return Explosion