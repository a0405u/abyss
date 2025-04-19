--- @class ToolTile
local ToolTile = class("ToolTile", Tool)


function ToolTile:init()

    self.ghost = sprites.tile_ghost
    self.block = nil
end


function ToolTile:use(position)

    if game.player:in_range(position, game.player.range) and self.block then
        if game:build_block(self.block:instantiate(), self.block.cost, position) then
            audio.play(sound.build)
        end
        audio.play(sound.deny)
    else
        game.player.sphere.show(game.player.range)
        audio.play(sound.deny)
    end
end


function ToolTile:activate(block)

    self.block = block
end


function ToolTile:update(dt)

end


function ToolTile:draw()

    self.ghost:draw(DL_GHOST, game.map.tilemap:get_draw_position(game.map.tilemap:get_position(ui.mouse.position.map)))
end

return ToolTile