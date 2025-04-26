--- @class UI : CanvasArea
local ui = class("UI", CanvasArea)
local economy = {}
local hint = {}


function ui:init()

    CanvasArea.init(self, Vector(0, 0), screen.size)

    self.left = UIElement(sprites.ui.left, DL_UI, Vector(0, 0))

    self.left.buttons = {
        platform = Button(Vector(19, 29), sprites.ui.button_small, sprites.ui.icons_small.platform, nil, nil,
        function() game:set_tool(game.tools.plank, Plank.Type.platform) end),
        beam = Button(Vector(37, 29), sprites.ui.button_small, sprites.ui.icons_small.beam, nil, nil,
        function() game:set_tool(game.tools.plank, Plank.Type.beam) end),
        wall = Button(Vector(19, 47), sprites.ui.button_small, sprites.ui.icons_small.wall, nil, nil,
        function() game:set_tool(game.tools.plank, Plank.Type.wall) end),
        hammer = Button(Vector(37, 47), sprites.ui.button_small, sprites.ui.icons_small.hammer, nil, nil,
        function() game:set_tool(game.tools.hammer) end),
        block = Button(Vector(56, 29), sprites.ui.button_small, sprites.ui.icons_small.block, nil, nil,
        function() game:set_tool(game.tools.tile, Block()) end),
        soil = Button(Vector(74, 29), sprites.ui.button_small, sprites.ui.icons_small.soil, nil, nil,
        function() game:set_tool(game.tools.tile, Soil()) end),
        wheat = Button(Vector(56, 47), sprites.ui.button_small, sprites.ui.icons_small.wheat, nil, nil,
        function() game:set_tool(game.tools.tile, Wheat()) end),
        tree = Button(Vector(74, 47), sprites.ui.button_small, sprites.ui.icons_small.trees, nil, nil,
        function() game:set_tool(game.tools.tile, Tree()) end),
        house = Button(Vector(19, 66), sprites.ui.button, sprites.ui.icons.house, nil, nil,
        function() game:set_tool(game.tools.building, House()) end),
        mine = Button(Vector(56, 66), sprites.ui.button, sprites.ui.icons.mine, nil, nil,
        function() game:set_tool(game.tools.building, Mine()) end),
        windmill = Button(Vector(19, 103), sprites.ui.button, sprites.ui.icons.windmill, nil, nil,
        function() game:set_tool(game.tools.building, Windmill()) end),
        sawmill = Button(Vector(56, 103), sprites.ui.button, sprites.ui.icons.sawmill, nil, nil,
        function() game:set_tool(game.tools.building, Sawmill()) end),
        townhall = Button(Vector(19, 140), sprites.ui.button, sprites.ui.icons.townhall, nil, true,
        function() game:set_tool(game.tools.building, Sawmill()) end),
        temple = Button(Vector(56, 140), sprites.ui.button, sprites.ui.icons.temple, nil, true,
        function() game:set_tool(game.tools.building, Sawmill()) end),
    }

    for key, button in pairs(self.left.buttons) do
        self.left:add(button)
    end
    self:add(self.left)

    local right = UIElement(sprites.ui.right, DL_UI, Vector(screen.size.x - sprites.ui.right.size.x, 0))
    self:add(right)

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
        ui:print(resource.value, Vector(position.x + economy.text.x, position.y + economy.text.y), economy.limit)
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
            ui:print(self.text, self.position, self.limit, "center", nil, a)
        end
    end


    function hint:update(dt)

        self.timer:update(dt)
    end


    ui.mouse = Mouse(sprites.mouse, screen.scale)
    ui.right = right
    ui.economy = economy
    ui.hint = hint
end


function ui:print(text, position, limit, align, dl, a)

    screen.layer:queue(dl or DL_UI_TEXT, function ()
        color.set(color.text, a)
        love.graphics.printf(text, font.small, position.x, position.y, limit, align) 
        color.reset()
        end)
end


function ui:draw()
    CanvasArea.draw(self)
    ui.mouse:draw()
    -- ui.left:draw()
    -- ui.right:draw()
    ui.economy:draw()
    ui.hint:draw()
end


function ui:update(dt)
    ui.mouse:update(dt)
    ui.economy:update(dt)
    ui.hint:update(dt)
end


return ui