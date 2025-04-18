--- @class ToolPlank
local ToolPlank = class("ToolPlank", Tool)


function ToolPlank:init()

    self.plank = nil
end


function ToolPlank:use(position)

    if not self.plank then
        if game.player:in_range(position, game.player.range) then
            self.plank = game:build_plank(position)
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