--- @class ToolHand
local ToolHand = class("ToolHand", Tool)


function ToolHand:init()

    self.object = nil
    self.joint = nil
    self.position = Vector()
    self.point = Vector()
    self.range = game.player.range * 2
    self.force = HAND_PULL_FORCE -- * ((DEBUG and 16) or 1)
end


function ToolHand:use(position)

    if game.player:in_range(position, self.range) then
        local objects = game.map:get_objects(position)

        for i, object in ipairs(objects) do
            if object:is(Plank) or object:is(Gib) then
                self.object = object
                if self.object.frozen then self.object:set_frozen(false) end
                self.joint = love.physics.newMouseJoint(self.object.body, ui.mouse.position.map:get())
                self.joint:setMaxForce(self.force)
                break
            end
        end
    else
        game.player.sphere.show(self.range)
        audio.play(sound.deny)
    end
end


function ToolHand:stop()

    self.object = nil
    if self.joint then self.joint:destroy() end
    self.joint = nil
end


function ToolHand:update(dt)

    if self.joint then
        if self.joint:isDestroyed() then
            self.joint = nil
            self.object = nil
            return
        end
        local x1, y1, x2, y2 = self.joint:getAnchors()
        self.position = Vector(x1, y1)
        self.point = Vector(x2, y2)
        local position = ui.mouse.position.map
        if not game.player:in_range(position, self.range) then
            position = (position - game.player.position):getNormalized() * self.range + game.player.position
            game.player.sphere.show(self.range)
        end
            self.joint:setTarget(position:get())
    end
end


function ToolHand:draw()

    if self.joint then
        local x1, y1 = game.map:get_draw_position(self.point):get()
        local x2, y2 = game.map:get_draw_position(self.position):get()
        local x3, y3 = game.map:get_draw_position(ui.mouse.position.map):get()
        screen.layer:queue(DL_UI, function ()
            color.set(color.darkest)
            love.graphics.line(x2, y2, x3, y3)
            color.set(color.dark)
            love.graphics.line(x1, y1, x2, y2)
        end)
    end
end


function ToolHand:activate()

end


return ToolHand