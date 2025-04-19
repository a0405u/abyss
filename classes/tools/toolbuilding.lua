--- @class ToolBuilding
local ToolBuilding = class("ToolBuilding", Tool)


function ToolBuilding:init()

    self.building = nil
end


function ToolBuilding:activate(building)

    self.building = building
end


function ToolBuilding:use(position)

    if self.building then
        if not game.economy:has(self.building.cost) then
            audio.play(sound.deny)
            ui.hint:queue("You don't have enough resources!")
            return
        end

        if game.player:in_range(position, game.player.range * 2) then
            if game:spawn_building(position, self.building) then
                game.economy:take(self.building.cost)
                self.building = nil
                audio.play(sound.build)
            end
        else
            game.player.sphere.show(game.player.range * 2)
        end
    end
end


function ToolBuilding:update(dt)

    if self.building then
        self.building.position = ui.mouse.position.map
        -- print(ui.mouse.position.map.x, ui.mouse.position.map.y)
        -- print(self.building.position.x, self.building.position.y)
        return
    end
end


function ToolBuilding:draw()
    if self.building then
        self.building:draw()
    end
end

return ToolBuilding