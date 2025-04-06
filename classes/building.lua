--- @class Building
local Building = class("Building", Object)


function Building:init(position, rotation, sprite, size)

    self.position = position or Vector2()
    self.rotation = rotation or 0.0
    self.sprite = sprite or sprites.building:instantiate()
    self.size = size or Vector2(15 / game.map.scale, 9 / game.map.scale)
    self.ghost = true
    self.body = love.physics.newBody(game.world, self.position.x, self.position.y, "dynamic")
end


function Building:destroy()

end


function Building:set_position(position)

    self.position = position
    self.body:setPosition(self.position.x, self.position.y)
end


function Building:unfreeze()

    self.fixture = love.physics.newFixture(self.body, love.physics.newRectangleShape(0, self.size.y / 2, self.size.x, self.size.y), 80)
    self.fixture:setCategory(PC_BUILDING)
    self.ghost = false
    self.body:setActive(true)
end


function Building:update(dt)

    if self.ghost then
        return
    end
    self.position.x, self.position.y = self.body:getPosition()
    self.rotation = self.body:getAngle()
end


function Building:draw()

    color.reset()
    local position = game.map:get_draw_position(self.position)
    self.sprite:draw(DL_BUILDING, position, -self.rotation)
end


return Building
