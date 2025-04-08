--- @class ToolBlock
local ToolBlock = class("ToolBlock", Tool)


function ToolBlock:init()

    self.ghost = sprites.tile_ghost
end


function ToolBlock:use(position)

    if game.player:in_range(position, game.player.range) then
        if game:build_block(Block(), COST_BLOCK, position) then
            audio.play(sound.build)
        end
        audio.play(sound.deny)
    else
        game.player.sphere.show(game.player.range)
        audio.play(sound.deny)
    end
end


function ToolBlock:update(dt)

end


function ToolBlock:draw()

    self.ghost:draw(DL_GHOST, game.map.tilemap:get_draw_position(game.map.tilemap:get_position(ui.mouse.position.map)))
end

return ToolBlock