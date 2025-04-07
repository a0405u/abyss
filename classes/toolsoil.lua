--- @class ToolSoil
local ToolSoil = class("ToolSoil", Tool)


function ToolSoil:init()

    self.ghost = sprites.tile_ghost
end


function ToolSoil:use(position)

    if game.player:in_range(position, game.player.range) then
        game:build_block(Soil(), COST_SOIL, position)
    else
        game.player.sphere.show(game.player.range)
    end
end


function ToolSoil:update(dt)

end


function ToolSoil:draw()

    self.ghost:draw(DL_GHOST, game.map.tilemap:get_draw_position(game.map.tilemap:get_position(ui.mouse.position.map)))
end

return ToolSoil