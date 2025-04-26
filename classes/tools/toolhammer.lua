--- @class ToolHammer : Tool
local ToolHammer = class("ToolHammer", Tool)


function ToolHammer:init()

end


function ToolHammer:use(position)

    local objects = game.map:get_objects(position)
    for i, object in ipairs(objects) do
        if (object:is(Plank) or object:is(Tile) or object:is(Building) or object:is(Gib)) and not object.indestructible then
            object:destroy()
            return
        end
    end
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