local ui = {}

local left = {}

left.sprite = sprites.ui.left
left.buttons = {
    plank = Button(left, Vector2(36, 46), sprites.ui.icons.plank, nil, nil,
        function() game:set_tool(game.tools.plank) end),
    block = Button(left, Vector2(73, 46), sprites.ui.icons.block, nil, nil,
        function() game:set_tool(game.tools.block) end),
    soil = Button(left, Vector2(36, 83), sprites.ui.icons.soil, nil, nil,
        function() game:set_tool(game.tools.soil) end),
    mine = Button(left, Vector2(73, 83), sprites.ui.icons.mine, nil, nil,
        function()
            game:set_tool(game.tools.building) 
            game.tool:activate(Mine())
        end),
    windmill = Button(left, Vector2(36, 120), sprites.ui.icons.windmill, nil, nil,
    function()
        game:set_tool(game.tools.building) 
        game.tool:activate(Windmill())
    end),
    sawmill = Button(left, Vector2(73, 120), sprites.ui.icons.sawmill, nil, nil,
    function()
        game:set_tool(game.tools.building) 
        game.tool:activate(Sawmill())
    end),
    -- house = Button(left, Vector2(73, 83), sprites.ui.icons.house, nil, true,
        -- function() game:set_tool(game.tools.house) end),
    -- townhall = Button(left, Vector2(73, 120), sprites.ui.icons.townhall, nil, true,
        -- function() game:set_tool(game.tools.townhall) end),
}


function left:draw()

    self.sprite:draw(DL_UI, Vector2(self.sprite.size.x / 2, self.sprite.size.y / 2))
    for key, button in pairs(self.buttons) do
        button:draw()
    end
end

local right = {}

right.sprite = sprites.ui.right

function right:draw()

    self.sprite:draw(DL_UI, Vector2(screen.width - self.sprite.size.x / 2, self.sprite.size.y / 2))
end

local economy = {}

economy.position = Vector2(16, 10)
economy.limit = 16
economy.text = Vector2(8, - font.small:getHeight() / 2)
economy.spacing = 32
economy.wood = {
        icon = sprites.icon.wood,
        value = 0,
    }
economy.stone = {
        icon = sprites.icon.stone,
        value = 0,
    }
economy.food = {
        icon = sprites.icon.food,
        value = 0,
    }

function economy:draw_resource(resource, position)

    resource.icon:draw(DL_UI_ICON, position)
    ui.print(resource.value, Vector2(position.x + economy.text.x, position.y + economy.text.y), economy.limit)
end

function economy:draw()

    self:draw_resource(self.wood, Vector2(economy.position.x + economy.spacing * 0, economy.position.y))
    self:draw_resource(self.stone, Vector2(economy.position.x + economy.spacing * 1, economy.position.y))
    self:draw_resource(self.food, Vector2(economy.position.x + economy.spacing * 2, economy.position.y))
end

function economy:update(dt)

    self.wood.value = math.floor(game.economy.wood.value)
    self.stone.value = math.floor(game.economy.stone.value)
    self.food.value = math.floor(game.economy.food.value)
end


ui.mouse = Mouse(sprites.mouse, screen.scale)
ui.left = left
ui.right = right
ui.economy = economy


function ui.get_button(position)

    for key, button in pairs(left.buttons) do
        if not button then return end
        if (button:is_inside(position)) then
            return button
        end
    end
end


function ui.print(text, position, limit, align, dl)

    screen.layer:queue(dl or DL_UI_TEXT, function ()
        color.set(color.text)
        love.graphics.printf(text, font.small, position.x, position.y, limit, align) 
        color.reset()
        end)
end


function ui.draw()
    ui.mouse:draw()
    ui.left:draw()
    ui.right:draw()
    ui.economy:draw()
end


function ui.update(dt)
    ui.mouse:update(dt)
    ui.economy:update(dt)
end


return ui