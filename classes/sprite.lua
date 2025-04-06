--- @class Sprite
--- @field animations table
--- @field parent table|nil
local Sprite = class("Sprite")


--- @param image love.Image
function Sprite:init(image, data, size, scale, offset, parent)

    self.image = image
    self.scale = scale or Vector2(1, 1)
    self.parent = parent or nil

    if data then
        self.size = size or Vector2(data.meta.size.w / #data.frames, data.meta.size.h)
        self.offset = offset or Vector2(self.size.x / 2, self.size.y / 2)

        if data.layers then
            self.data = data
        else
            self.data = {
                tags = data.meta.frameTags,
                layers = data.meta.layers,
                slices = data.meta.slices,
                frames = data.frames
            }
        end
        
        self.animations = {}
        for i, tag in ipairs(self.data.tags) do
            local offset = Vector2(self.size.x * tag.from, 0)
            local count = tag.to - tag.from + 1
            local frames = Animation.get_frames(self.image, self.size, offset, count)
            local durations = {}
            for j = tag.from + 1, tag.to do
                table.insert(durations, self.data.frames[j].duration / 1000)
            end
            self.animations[tag.name] = Animation(self.image, frames, durations)
        end
        self.animation = self.animations[self.data.tags[1].name]
    else
        self.size = size or Vector2(image:getWidth(), image:getHeight())
        self.offset = offset or Vector2(self.size.x / 2, self.size.y / 2)
        self.animations = {idle = Animation(image)}
        self.animation = self.animations.idle
    end
end


function Sprite:instantiate(parent)

    return Sprite(self.image, self.data, self.size, self.scale, self.offset, self.parent)
end


function Sprite:set(animation, play)

    self.animation = animation
    if play then self.animation.play() end
end

--- @param dl number
--- @param position Vector2|nil
--- @param rotation number|nil
--- @param scale Vector2|nil
--- @param offset Vector2|nil
function Sprite:draw(dl, position, rotation, scale, offset)

    scale = scale or self.scale
    offset = offset or self.offset
    screen.layer:queue(dl, function()
        self.animation:draw(position, rotation, scale, offset)
    end)
end


function Sprite:update(dt)

    self.animation:update(dt)
end


function Sprite:play()

end

function Sprite:getWidth() return self.width end
function Sprite:getHeight() return self.height end

return Sprite
