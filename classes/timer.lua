--- @class Timer
--- @field time number
--- @field left number
--- @field action function
--- @field active boolean
local Timer = class("Timer")

--- @param action function | nil
--- @param time number | nil
---@param active boolean | nil
function Timer:init(action, time, active, continuous)

    self.time = time or 1
    self.left = self.time

    self.action = action or function() end
    self.continuous = continuous or false

    self.active = active or false
end


function Timer:update(dt)

    if not self.active then
        return
    end

    self.left = self.left - dt

    if self.left <= 0 then
        self:timeout()
    end
end


function Timer:timeout()

    self.active = false
    self:action()
    if self.continuous then
        self:restart()
    end
end


function Timer:restart()

    self.left = self.time
    self.active = true
end


function Timer:start(time, action)

    self.action = action or self.action
    self.time = time or self.time
    self.left = self.time
    self.active = true
end


function Timer:set(time)

    self.time = time
    self.left = self.time
end


function Timer:stop()

    self.active = false
end


return Timer