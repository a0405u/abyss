--- @class Gib: Drawable
local Gib = class("Gib", Drawable)


function Gib:init(position, rotation, sprite, dl)

    sprite = sprite or sprites.gib[math.random(1, #sprites.gib)]
    dl = dl or DL_GIB
    Drawable.init(self, position, sprite, dl)
    self.rotation = rotation or 0.0
    self.body = love.physics.newBody(game.world, self.position.x, self.position.y, "dynamic")
end


function Gib:update(dt)

    self.position.x, self.position.y = self.body:getPosition()
    self.rotation = self.body:getAngle()
end


function Gib:draw()

    local position = game.map:get_draw_position(self.position)
    self.sprite:draw(DL_GIB, position, -self.rotation, nil, nil, c, a)
end


function Gib:place()

    local collider = self.sprite.data.slices[1]
    local w = collider.keys[1].bounds.w / game.map.scale
    local h = collider.keys[1].bounds.h / game.map.scale

    self.fixture = love.physics.newFixture(self.body, love.physics.newRectangleShape(0, h / 2, w, h), DS_BUILDING)
    self.fixture:setCategory(PC_GIB)
    
    self.body:setActive(true)
end


return Gib
