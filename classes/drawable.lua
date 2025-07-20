--- @class Drawable : Object
--- @field position Vector
--- @field rotation number
--- @field sprite Sprite
--- @field dl number
local Drawable = class("Drawable", Object)

--- @param position Vector | nil
--- @param rotation number | nil
--- @param sprite Sprite
--- @param dl number
function Drawable:init(position, rotation, sprite, dl)
    assert(sprite, "No sprite on Drawable!")
    assert(dl, "No drawing layer on Drawable!")

    Object.init(self)
    self.position = position or Vector()
    self.rotation = rotation or 0.0
    self.sprite = sprite:clone()
    self.dl = dl
end


function Drawable:update(dt)

    self.sprite:update(dt)
end


function Drawable:draw(position, camera_scale)

    -- print(game.map:get_draw_position(self.position).x, game.map:get_draw_position(self.position).y)
    self.sprite:draw(self.dl, game.map:get_draw_position(position or self.position, camera_scale), -self.rotation)
end


return Drawable
