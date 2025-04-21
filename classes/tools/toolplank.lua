--- @class ToolPlank
local ToolPlank = class("ToolPlank", Tool)


function ToolPlank:init()

    self.plank = nil
    self.joint = nil
    self.weld = nil
    self.object = nil
    self.range = RNG_PLANK_TOOL * ((DEBUG and 8) or 1)
    self.force = MOUSE_PULL_FORCE -- * ((DEBUG and 16) or 1)
end


function ToolPlank:build(position)

    if game.economy:has(COST_PLANK) then
        game.economy:take(COST_PLANK)
        local plank = Plank(position)
        game.map:add(plank)
        return plank
    else
        ui.hint:queue("You don't have enough resources!")
        audio.play(sound.deny)
    end
    return nil, {}
end


function ToolPlank:place()

    self.plank:place()
end


function ToolPlank:use(position)

    if not self.plank then
        if game.player:in_range(position, self.range) then
            self.plank = self:build(position)
            if self.plank then
                audio.play(sound.select)
                self.joint = love.physics.newMouseJoint(self.plank.body, self.plank.point:get())
                self.joint:setMaxForce(self.force)
                -- self.joint:setDampingRatio(MOUSE_DAMPING)
                -- self.joint:setFrequency(MOUSE_FREQUENCY)
                local fixtures = game.map:get_fixtures(self.plank.position)
                local body = game.map.body
                for i, fixture in ipairs(fixtures) do
                    if fixture ~= self.plank.fixture and fixture:getCategory() == PC_PLANK then
                        body = fixture:getBody()
                        break
                    end
                end
                self.weld = love.physics.newRevoluteJoint(self.plank.body, body, self.plank.position:get())
            end
        else
            game.player.sphere.show(self.range)
            audio.play(sound.deny)
        end
    else
        self:place()
        self.joint:destroy()
        self.joint = nil
        if not self.weld:isDestroyed() then
            self.weld:destroy()
        end
        self.weld = nil
        self.plank = nil
        audio.play(sound.build)
    end
end


function ToolPlank:deny()

    self.joint:destroy()
    self.joint = nil
    if not self.weld:isDestroyed() then
        self.weld:destroy()
    end
    self.weld = nil
    self.plank.body:destroy()
    self.plank.parent:remove(self.plank)
    self.plank = nil
    audio.play(sound.deny)
end


function ToolPlank:secondary()

    if self.plank then
        self:deny()
    end
end


function ToolPlank:update(dt)

    if self.plank then
        -- self.plank:set_point(ui.mouse.position.map)
        if not game.player:in_range(self.plank.position, self.range * 2) then
            self:deny()
            game.player.sphere.show(self.range * 2)
            return
        end
        local position = ui.mouse.position.map
        if not game.player:in_range(position, self.range * 2) then
            position = (position - game.player.position):getNormalized() * self.range * 2 + game.player.position
        end
        self.joint:setTarget(position:get())
        local vector = position - self.plank.position
        self.plank:set_angle(vector:getAngle())
        local length = vector:getLength()
        self.plank:set_length(length)
        return
    end
end


function ToolPlank:draw()

end

return ToolPlank