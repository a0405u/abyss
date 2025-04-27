--- @class Camera
local Camera = class("Camera")


function Camera:init(position, offset)

    self.position = position or Vector()
    self.offset = offset or Vector()
    self.draw_position = self.position
    self.canvas = canvas.screen.camera
end


function Camera:update(dt)

    self.position.x = game.player.position.x - game.map.size.x / 2
    self.position.y = game.player.position.y - game.map.size.y / 2
    self.position.y = math.max(self.position.y, 0)
end


function Camera:draw()

end


return Camera
