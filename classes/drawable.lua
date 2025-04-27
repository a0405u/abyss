--- @class Drawable: Object
--- @field position Vector
--- @field sprite Sprite
--- @field dl number
local Drawable = class("Drawable", Object)

--- @param position Vector
---@param sprite Sprite
---@param dl number
function Drawable:init(position, sprite, dl)
    assert(position, "No position on Drawable!")
    assert(sprite, "No sprite on Drawable!")
    assert(dl, "No drawing layer on Drawable!")

    self.position = position
    self.sprite = sprite
    self.dl = dl
end


function Drawable:update(dt)

end


function Drawable:draw(position, camera_scale)

    -- print(game.map:get_draw_position(self.position).x, game.map:get_draw_position(self.position).y)
    self.sprite:draw(self.dl, game.map:get_draw_position(position or self.position, camera_scale))
end


return Drawable
