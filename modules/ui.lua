local ui = {}
local left = {}
local right = {}
local economy = {}
local hint = {}

function ui.load()


    left.sprite = sprites.ui.left
    left.buttons = {
        plank = Button(left, Vector(36, 46), sprites.ui.icons.plank, nil, nil,
            function() game:set_tool(game.tools.plank) end),
        block = Button(left, Vector(73, 46), sprites.ui.icons.block, nil, nil,
            function() game:set_tool(game.tools.tile, Block()) end),
        soil = Button(left, Vector(36, 83), sprites.ui.icons.soil, nil, nil,
            function() game:set_tool(game.tools.tile, Soil()) end),
        mine = Button(left, Vector(73, 83), sprites.ui.icons.mine, nil, nil,
            function()
                game:set_tool(game.tools.building, Mine())
            end),
        windmill = Button(left, Vector(36, 120), sprites.ui.icons.windmill, nil, nil,
        function()
            game:set_tool(game.tools.building, Windmill())
        end),
        sawmill = Button(left, Vector(73, 120), sprites.ui.icons.sawmill, nil, nil,
        function()
            game:set_tool(game.tools.building, Sawmill())
        end),
        -- house = Button(left, Vector(73, 83), sprites.ui.icons.house, nil, true,
            -- function() game:set_tool(game.tools.house) end),
        -- townhall = Button(left, Vector(73, 120), sprites.ui.icons.townhall, nil, true,
            -- function() game:set_tool(game.tools.townhall) end),
    }


    function left:draw()

        self.sprite:draw(DL_UI, Vector(self.sprite.size.x / 2, self.sprite.size.y / 2))
        for key, button in pairs(self.buttons) do
            button:draw()
        end
    end

    right.sprite = sprites.ui.right

    function right:draw()

        self.sprite:draw(DL_UI, Vector(screen.size.x - self.sprite.size.x / 2, self.sprite.size.y / 2))
    end


    economy.position = Vector(16, 10)
    economy.limit = 16
    economy.text = Vector(8, - font.small:getHeight() / 2)
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
        ui.print(resource.value, Vector(position.x + economy.text.x, position.y + economy.text.y), economy.limit)
    end

    function economy:draw()

        self:draw_resource(self.wood, Vector(economy.position.x + economy.spacing * 0, economy.position.y))
        self:draw_resource(self.stone, Vector(economy.position.x + economy.spacing * 1, economy.position.y))
        self:draw_resource(self.food, Vector(economy.position.x + economy.spacing * 2, economy.position.y))
    end

    function economy:update(dt)

        self.wood.value = math.floor(game.economy.wood.value)
        self.stone.value = math.floor(game.economy.stone.value)
        self.food.value = math.floor(game.economy.food.value)
    end


    hint.position = Vector(151, 10 - font.small:getHeight() / 2)
    hint.limit = screen.size.x - 154 - 151
    hint.text = ""
    hint.last = 0
    hint.time = 0
    hint.timer = Timer()


    function hint:show(text, time)
        self.text = text
        self.time = time or 10
        self.last = love.timer.getTime()
        audio.play(sound.hint)
    end


    function hint:queue(text, time, delay)
        delay = delay or 1
        self.timer:start(delay, function() ui.hint:show(text, time) end)
    end


    function hint:draw()
        local time = love.timer.getTime()
        local delta = time - self.last
        local a = hint.time - delta

        if a > 0 then
            ui.print(self.text, self.position, self.limit, "center", nil, a)
        end
    end


    function hint:update(dt)

        self.timer:update(dt)
    end


    ui.mouse = Mouse(sprites.mouse, screen.scale)
    ui.left = left
    ui.right = right
    ui.economy = economy
    ui.hint = hint
end


function ui.get_button(position)

    for key, button in pairs(left.buttons) do
        if not button then return end
        if (button:is_inside(position)) then
            return button
        end
    end
end


function ui.print(text, position, limit, align, dl, a)

    screen.layer:queue(dl or DL_UI_TEXT, function ()
        color.set(color.text, a)
        love.graphics.printf(text, font.small, position.x, position.y, limit, align) 
        color.reset()
        end)
end


function ui.draw()
    ui.mouse:draw()
    ui.left:draw()
    ui.right:draw()
    ui.economy:draw()
    ui.hint:draw()
end


function ui.update(dt)
    ui.mouse:update(dt)
    ui.economy:update(dt)
    ui.hint:update(dt)
end


return ui