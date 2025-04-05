local Filter = class("Filter")

---@class Filter
function Filter:init(allow, items)

    self.allow = allow
    
    for key, item in pairs(items) do
        self[item] = true
    end
end

return Filter