--- @class Gib: Body
local Gib = class("Gib", Body)

--- @param position Vector
---@param rotation number | nil
---@param sprite Sprite | nil
---@param dl number | nil
function Gib:init(position, rotation, sprite, dl)

    sprite = sprite or sprites.gib[math.random(1, #sprites.gib)]
    Body.init(self, position, rotation, sprite, dl or DL_GIB)
    
    self.durability = DUR_GIB
end


function Gib:update(dt)

    self.position.x, self.position.y = self.body:getPosition()
    self.rotation = self.body:getAngle()

    if self.position.y <= -4 then
        audio.play(sound.sink.gib, nil, 0.75 + math.random() * 0.75)
        self.body:destroy()
        self.parent:remove(self)
        return
    end

    local fraction = self.dimpulse / (self.durability * self.body:getMass())
    local volume = math.min(fraction * fraction * 2, 1.0)
    audio.play(sound.hit.gib, volume, math.random() * 0.25 + 0.75)

    if self.dimpulse > self.durability * self.body:getMass() then
        self.update = function(dt) self:destroy() end
    end
    
    self.dimpulse = 0.0
end


function Gib:place()

    local collider = self.sprite.data.slices[1]
    local w = collider.keys[1].bounds.w / game.map.scale
    local h = collider.keys[1].bounds.h / game.map.scale

    self.fixture = love.physics.newFixture(self.body, love.physics.newRectangleShape(0, h / 2, w, h), DS_BUILDING)
    self.fixture:setCategory(PC_GIB)
    
    self.body:setActive(true)
end


function Gib:begincontact(a, b, contact)

end


function Gib:destroy(position)

    audio.play(sound.destroy.gib, nil, 0.75 + math.random() * 0.5)
    self.body:destroy()
    self.parent:remove(self)
end


return Gib
