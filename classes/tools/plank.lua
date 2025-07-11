--- @class ToolPlank
--- @field plank Plank | nil
--- @field weld love.Joint | nil
--- @field range number
--- @field force number
--- @field surface Plank | Block | nil
--- @field origin Map | Plank | Block | nil
--- @field point Vector
local ToolPlank = class("ToolPlank", Tool)


function ToolPlank:init()

    self.plank = nil
    -- self.joint = nil
    self.weld = nil
    self.support = nil
    self.range = RNG_PLANK_TOOL * ((DEBUG and 8) or 1)
    self.force = HAND_PULL_FORCE -- * ((DEBUG and 16) or 1)
    self.surface = nil
    self.origin = nil
    self.point = Vector()
    self.type = nil
end

--- @param type PlankType
function ToolPlank:activate(type)

    self.type = type
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

    if self.plank:activate(true) then
        self.plank:set_frozen(false)
        self.plank:add_nail(self.plank.position)
        if self.surface then
            self.plank:add_nail(self.plank.point)
        end
        self.plank:set_type(self.type)
    end
end


function ToolPlank:use(position)

    if not self.plank then
        if game.player:in_range(position, self.range) then
            self.plank = self:build(position)
            if self.plank then
                audio.play(sound.select)
                -- self.joint = love.physics.newMouseJoint(self.plank.body, self.plank.point:get())
                -- self.joint:setMaxForce(self.force)
                -- self.joint:setDampingRatio(MOUSE_DAMPING)
                -- self.joint:setFrequency(MOUSE_FREQUENCY)
                self.origin = game.map
                if self.surface then self.origin = self.surface end
                if self.origin:is(Plank) and self.origin:is_nailed() then
                    -- self.surface:set_frozen(true)
                    self.support = love.physics.newMouseJoint(self.origin.body, position.x, position.y)
                    self.support:setMaxForce(self.force)
                end
                self.weld = love.physics.newRevoluteJoint(self.plank.body, self.origin.body, self.plank.position:get())
            end
        else
            game.player.sphere.show(self.range)
            audio.play(sound.deny)
        end
    else
        self:place()
        -- self.joint:destroy()
        -- self.joint = nil
        if not self.weld:isDestroyed() then
            self.weld:destroy()
        end
        if self.origin:is(Plank) then
            self.origin:set_frozen(false)
        end
        self.weld = nil
        self.plank = nil
        self.origin = nil
        audio.play(sound.build)
    end
end


function ToolPlank:deny()

    -- self.joint:destroy()
    -- self.joint = nil
    if not self.weld:isDestroyed() then
        self.weld:destroy()
    end
    if self.support then
        if not self.support:isDestroyed() then self.support:destroy() end
        self.support = nil
    end
    self.weld = nil
    if not self.plank.body:isDestroyed() then self.plank.body:destroy() end
    self.plank.parent:remove(self.plank)
    self.plank = nil
    self.origin = nil
    audio.play(sound.deny)
end


function ToolPlank:secondary()

    if self.plank then
        self:deny()
    end
end


function ToolPlank:update(dt)

    self.surface = nil

    if self.plank then
        if self.plank.body:isDestroyed() then return self:deny() end
        if not game.player:in_range(self.plank.position, self.range * 2) then
            self:deny()
            game.player.sphere.show(self.range * 2)
            return
        end
        if self.support then
            if not self.support:isDestroyed() then
                -- self.support:setTarget(self.plank.position:get())
            else
                self.support = nil
            end
        end
        local position = ui.mouse.position.map
        if not game.player:in_range(position, self.range * 2) then
            position = (position - game.player.position):getNormalized() * self.range * 2 + game.player.position
            game.player.sphere.show(self.range * 2)
        end
        local vector = position - self.plank.position
        self.plank:set_angle(vector:getAngle())
        local length = vector:getLength()
        self.plank:set_length(length)
        -- local drag_position = self.plank.position + vector * (length - self.plank.length)
        -- self.joint:setTarget(drag_position:get())
        self.point = self.plank.point
        if self.plank.length == length then
            self:update_surface(self.point)
        end
    else
        self.point = ui.mouse.position.map
        self:update_surface(self.point)
    end
end


function ToolPlank:update_surface(position)

    local fixtures = game.map:get_fixtures(position)
    for i, fixture in ipairs(fixtures) do
        local category = fixture:getCategory()
        if self.plank and fixture == self.plank.fixture then goto continue end
        if category ~= PC_PLANK and category ~= PC_BLOCK then goto continue end
        local object = fixture:getBody():getUserData()
        if object:is(Tile) and object.solid ~= true then goto continue end
        self.surface = object
        do break end
        ::continue::
    end
end


function ToolPlank:draw()

    if self.plank then
        local x1, y1 = game.map:get_draw_position(self.plank.point):get()
        local x2, y2 = game.map:get_draw_position(ui.mouse.position.map):get()
        screen.layer:queue(DL_UI, function ()
            color.set(color.darkest)
            love.graphics.line(x1, y1, x2, y2)
        end)
    end
    if self.surface then
        local x, y = game.map:get_draw_position(self.point):get()
        screen.layer:queue(DL_UI_MOUSE, function ()
            color.set(color.dark)
            love.graphics.circle("line", x, y, 3.7)
        end)
    end
    if self.origin and self.origin:is(Plank) then
        local position = game.map:get_draw_position(Vector(self.weld:getAnchors()))
        screen.layer:queue(DL_UI_MOUSE, function ()
            color.set(color.dark)
            love.graphics.circle("line", position.x, position.y, 1.5)
        end)
    end
end

return ToolPlank