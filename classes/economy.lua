--- @class Economy
local Economy = class("Economy")


function Economy:init()

    self.wood = Resource(BASE_WOOD)
    self.stone = Resource(BASE_STONE)
    self.food = Resource(BASE_FOOD)
end


function Economy:has(amount)

    return
        self.wood:has(amount.wood) and
        self.stone:has(amount.stone) and
        self.food:has(amount.food)
end


function Economy:take(amount)

    if self:has(amount) then
        if DEBUG then return true end
        self.wood:take(amount.wood)
        self.stone:take(amount.stone)
        self.food:take(amount.food)
        return true
    end
    return false
end


function Economy:add(amount, mult)

    self.wood:add(amount.wood * mult)
    self.stone:add(amount.stone * mult)
    self.food:add(amount.food * mult)
end


function Economy:update(dt)

end


function Economy:draw()

end


return Economy
