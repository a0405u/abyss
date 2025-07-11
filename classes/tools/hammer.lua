--- @class ToolHammer : Tool
local ToolHammer = class("ToolHammer", Tool)


function ToolHammer:init()

end


function ToolHammer:use(position)

    local objects = game.map:get_objects(position)
    for i, object in ipairs(objects) do
        if (object:is(Plank) or object:is(Building) or object:is(Gib)) and not object.indestructible then
            object:destroy()
            return
        end
    end
    local tile_position = game.map.tilemap:get_position(position)
    game.map.tilemap:remove(tile_position)
end


function ToolHammer:update(dt)

end


function ToolHammer:draw()

end


function ToolHammer:activate()

end


function ToolHammer:secondary()

end


return ToolHammer