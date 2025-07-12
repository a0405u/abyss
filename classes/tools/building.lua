--- @class ToolBuilding
--- @field building Building|nil
--- @field group table|nil
--- @field index number|nil
--- @field respawn boolean|nil
local ToolBuilding = class("ToolBuilding", Tool)

--- comment
function ToolBuilding:init()

    self.building = nil
    self.group = nil
    self.index = nil
    self.respawn = false
end


--- Activate tool
--- @param building Building|table
--- @param respawn boolean|nil
function ToolBuilding:activate(building, respawn)

    if #building > 0 and building[1]:is(Building) then
        self.group = building
        self.building = self.group[1]
        self.index = 1
    else
        self.group = nil
        self.building = building
        self.index = nil
    end
    self.respawn = respawn or false
end


function ToolBuilding:use(position)

    if self.building then
        if not game.economy:has(self.building.cost) then
            audio.play(sound.deny)
            ui.hint:queue("You don't have enough resources!")
            return
        end

        position = position - Vector(0, self.building.bb.size.y / 2)
        if game.player:in_range(position, game.player.range * 2) then
            local tile = game.map.tilemap:get_tile(position)
            if tile and tile.solid then return end
            game:spawn_building(position, self.building:instantiate())
            game.economy:take(self.building.cost)
            self.building = self.respawn and self.building or nil
            audio.play(sound.build)
        else
            game.player.sphere.show(game.player.range * 2)
        end
    end
end


function ToolBuilding:switch(direction)

    if self.group then
        self.index = loop_index(self.index + direction, #self.group)
        self.building = self.group[self.index]
    end
end


function ToolBuilding:update(dt)

    if self.building then
        self.building.position = ui.mouse.position.map - Vector(0, self.building.bb.size.y / 2)
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