--- @class Drawable: Object
local Drawable = class("Drawable", Object)


function Drawable:init(position, sprite, dl)
    assert(sprite, "No sprite on Drawable!")

    self.position = position
    self.sprite = sprite
    self.dl = dl
end


function Drawable:update(dt)

end


function Drawable:draw()

    -- print(game.map:get_draw_position(self.position).x, game.map:get_draw_position(self.position).y)
    self.sprite:draw(self.dl, game.map:get_draw_position(self.position))
end


return Drawable
