--- @class ToolHand
local ToolHand = class("ToolHand", Tool)


function ToolHand:init()

    self.object = nil
    self.joint = nil
    self.range = game.player.range * 2
    self.force = MOUSE_PULL_FORCE * ((DEBUG and 16) or 1)
end


function ToolHand:use(position)

    if self.object then
        self.object = nil
        self.joint:destroy()
        self.joint = nil
        return
    end

    if game.player:in_range(position, game.player.range) then
        local objects = game.map:get_objects(position)

        for i, object in ipairs(objects) do
            if object:is(Plank) or object:is(Gib) then
                self.object = object
                self.joint = love.physics.newMouseJoint(self.object.body, ui.mouse.position.map:get())
                self.joint:setMaxForce(self.force)
                break
            end
        end
    else
        game.player.sphere.show(game.player.range)
        audio.play(sound.deny)
    end
end


function ToolHand:update(dt)

    if self.joint then
        if self.joint:isDestroyed() then
            self.joint = nil
            self.object = nil
            return
        end
        local position = ui.mouse.position.map
        if not game.player:in_range(position, self.range) then
            position = (position - game.player.position):getNormalized() * self.range + game.player.position
        end
            self.joint:setTarget(position:get())
    end
end


function ToolHand:draw()

end


function ToolHand:activate()

end


return ToolHand