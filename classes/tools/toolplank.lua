--- @class ToolPlank
local ToolPlank = class("ToolPlank", Tool)


function ToolPlank:init()

    self.plank = nil
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


function ToolPlank:use(position)

    if not self.plank then
        if game.player:in_range(position, game.player.range) then
            self.plank, self.objects = self:build(position)
            if self.plank then
                audio.play(sound.select)
            end
        else
            game.player.sphere.show(game.player.range)
            audio.play(sound.deny)
        end
    else
        self.plank:place()
        audio.play(sound.build)
        self.plank = nil
    end
end


function ToolPlank:update(dt)

    if self.plank then
        self.plank:set_point(ui.mouse.position.map)
        return
    end
end


function ToolPlank:draw()

end

return ToolPlank