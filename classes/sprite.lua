--- @class Sprite
--- @field animations table
--- @field parent table|nil
local Sprite = class("Sprite")


--- @param input table|love.Image|Animation
function Sprite:init(input, scale, offset, parent)
    assert(input, "No input provided for Sprite!")

    if type(input) == "string" then
        local filepath = input
        input = {}
        input.image = love.graphics.newImage(filepath .. ".png")
        input.data = json.decode(love.filesystem.newFile(filepath .. ".json"))
    end

    if type(input) == "table" and input.image and input.data then
        self.data = {
            tags = input.data.meta.frameTags,
            layers = input.data.meta.layers,
            slices = input.data.meta.slices,
        }
        self.image = image
        self.animations = {}
        for i, tag in self.data.tags do
            local frames = 
            self.animations[tag.name] = Animation()
        end
    end

    if input.typeOf and input:typeOf("Image") then
        self.animations = {idle = Animation(input)}
    elseif input.is_a and input.is_a.Animation then
        self.animations = {idle = input}
    else
        self.animations = input
    end

    for i, animation in pairs(self.animations) do
        animation.parent = self
    end

    assert(self.animations.idle, "No idle animation provided for Sprite!")
    self.parent = parent or nil
    self.animation = self.animations.idle
    self.size = self.animations.idle.size
    self.scale = scale or Vector2(1, 1)
    self.offset = offset or Vector2(0, 0)
end


function Sprite:instantiate(parent)

    local animations = {}
    for key, animation in pairs(self.animations) do
        animations[key] = animation:instantiate()
    end
    return Sprite(animations, self.scale, self.offset, parent)
end


--- @param position Vector2|nil
--- @param rotation number|nil
--- @param scale Vector2|nil
--- @param offset Vector2|nil
function Sprite:draw(position, rotation, scale, offset)

    scale = scale or self.scale
    offset = offset or self.offset
    self.animation:draw(position, rotation, scale, offset)
end


function Sprite:update(dt)

    self.animation:update(dt)
end


function Sprite:play()

end

function Sprite:getWidth() return self.width end
function Sprite:getHeight() return self.height end

return Sprite
