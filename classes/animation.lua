--- @class Animation
local Animation = class("Animation")

--- @param image love.Image
--- @param durations table|number|nil
--- @param frames table|nil
--- @param on_loop function|nil
function Animation:init(image, frames, durations, on_loop, parent)

    assert(image, "No image provided for Animation!")
    if frames == nil then frames = Animation.get_frames(image, Vector2(image:getHeight(), image:getHeight()), Vector2(0, 0), image:getWidth() / image:getHeight()) end
    if durations == nil then durations = 1 end
    if (type(durations) == "number") then
        local duration = durations
        durations = {}
        for i = 1, #frames do
            durations[i] = duration
        end
    end

    self.parent = parent or nil
    self.image = image
    self.size = frames.size
    self.frames = frames
    self.durations = durations
    self.frame = 1
    self.on_loop = on_loop or function () return end
    self.timer = Timer(function () self:next_frame() end)
end


function Animation:instantiate(parent)

    return Animation(self.image, self.frames, self.durations, self.on_loop, parent)
end


function Animation:play()

    self.timer:start(self.durations[self.frame])
end


function Animation:update(dt)

    self.timer:update(dt)
end


function Animation:draw(position, rotation, scale, offset)

    love.graphics.draw(self.image, self.frames[self.frame], position.x, position.y, rotation, scale.x, scale.y, offset.x, offset.y)
end


function Animation:next_frame()

    self.frame = self.frame + 1
    self.timer:start(self.durations[self.frame])

    if self.frame > #self.frames then
        self:on_loop()
        self:restart()
    end
end


function Animation:restart()
    
    self.frame = 1
    self.timer:start(self.durations[self.frame])
end


function Animation.get_frames(image, size, offset, count)

    local frames = {}
    for i = 1, count do
        frames[i] = love.graphics.newQuad(offset.x + size.x * (i - 1), offset.y, size.x, size.y, image)
    end
    frames.size = size
    return frames
end


return Animation
