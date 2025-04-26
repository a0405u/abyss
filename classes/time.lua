--- @class Time
local Time = class("Time")


function Time:init()

    self.timers = {}
end


function Time:update(dt)

    for key, timer in pairs(self.timers) do
        timer:update(dt)
    end
end

--- Delay an action
--- @param action function
--- @param time number
--- @param continuous boolean | nil
function Time:delay(action, time, continuous)

    local timer = Timer(nil, time, nil, continuous)
    timer:start(time or 1, function()
        action()
        self.timers[timer] = nil
    end)
    self.timers[timer] = timer
end


return Time
