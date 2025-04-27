--- @class UI : CanvasArea
local ui = class("UI", CanvasArea)
local economy = {}
local hint = {}


function ui:init()

    CanvasArea.init(self, Vector(0, 0), screen.size)

    self.left = UIElement(sprites.ui.left, DL_UI, Vector(0, 0))
    self:add(self.left)

    self.left.buttons = {
        platform = Button(Vector(19, 29), sprites.ui.button_small, sprites.ui.icons_small.platform, nil, nil,
        function() game:set_tool(game.tools.plank, Plank.Type.platform) end),
        beam = Button(Vector(37, 29), sprites.ui.button_small, sprites.ui.icons_small.beam, nil, nil,
        function() game:set_tool(game.tools.plank, Plank.Type.beam) end),
        wall = Button(Vector(19, 47), sprites.ui.button_small, sprites.ui.icons_small.wall, nil, nil,
        function() game:set_tool(game.tools.plank, Plank.Type.wall) end),
        support = Button(Vector(37, 47), sprites.ui.button_small, sprites.ui.icons_small.support, nil, nil,
        function() game:set_tool(game.tools.tile, Support()) end),
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

        hammer = Button(Vector(109, 0), sprites.ui.button_top, sprites.ui.icons_small.hammer, nil, nil,
        function() game:set_tool(game.tools.hammer) end),
    }

    for key, button in pairs(self.left.buttons) do
        self.left:add(button)
    end

    local right = UIElement(sprites.ui.right, DL_UI, Vector(screen.size.x - sprites.ui.right.size.x, 0))
    self:add(right)

    right.name = "Platform"
    right.description = ""
    right.cost = COST_PLANK
    right.preview = sprites.ui.preview.planks
    right.set_tool = function(e, tool, ...)

        if tool:is(ToolPlank) then
            if tool.type == Plank.Type.platform then
                e.name = "Platform"
                e.description = "It can allow you to go one way."
                e.cost = COST_PLANK
                e.preview = sprites.ui.preview.planks
                return
            end
            if tool.type == Plank.Type.beam then
                e.name = "Beam"
                e.description = "It can give you a bit of support."
                e.cost = COST_PLANK
                e.preview = sprites.ui.preview.planks
                return
            end
            if tool.type == Plank.Type.wall then
                e.name = "Wall"
                e.description = "You could try to stop something with it."
                e.cost = COST_PLANK
                e.preview = sprites.ui.preview.planks
                return
            end
        end
        if tool:is(ToolTile) then
            if tool.block:is(Block) then
                e.name = "Block"
                e.description = "It's hard and heavy."
                e.cost = COST_BLOCK
                e.preview = sprites.ui.preview.block
                return
            end
            if tool.block:is(Support) then
                e.name = "Support"
                e.description = "It gives a bit of stability."
                e.cost = COST_SUPPORT
                e.preview = sprites.ui.preview.support
                return
            end
            if tool.block:is(Soil) then
                e.name = "Soil"
                e.description = "It's moist and unstable."
                e.cost = COST_SOIL
                e.preview = sprites.ui.preview.soil
                return
            end
            if tool.block:is(Tree) then
                e.name = "Tree"
                e.description = "It is warm but the leaves are falling."
                e.cost = COST_TREE
                e.preview = sprites.ui.preview.tree
                return
            end
            if tool.block:is(Wheat) then
                e.name = "Wheat"
                e.description = "How can it grow in such darkness?"
                e.cost = COST_WHEAT
                e.preview = sprites.ui.preview.wheat
                return
            end
        end
        if tool:is(ToolBuilding) then
            if tool.building:is(House) then
                e.name = "House"
                e.description = "There is no one to live here."
                e.cost = COST_HOUSE
                e.preview = sprites.ui.preview.house
            end
            if tool.building:is(Mine) then
                e.name = "Mine"
                e.description = "You could go even deeper."
                e.cost = COST_MINE
                e.preview = sprites.ui.preview.mine
            end
            if tool.building:is(Sawmill) then
                e.name = "Sawmill"
                e.description = "It could saw trees if you had some."
                e.cost = COST_SAWMILL
                e.preview = sprites.ui.preview.sawmill
            end
            if tool.building:is(Windmill) then
                e.name = "Windmill"
                e.description = "There is no wind in here."
                e.cost = COST_WINDMILL
                e.preview = sprites.ui.preview.windmill
            end
        end
        if tool:is(ToolHammer) then
            e.name = "Hammer"
            e.description = "You won't be able to hurt anyone."
            e.cost = COST_NONE
            e.preview = sprites.ui.preview.hammer
        end
    end

    right.draw = function(e)
        UIElement.draw(e)

        self:print(self.right.name, Vector(488, 72), 152, "center")
        self:print(self.right.description, Vector(534, 94), 70, "left")

        self.right.preview:draw(DL_UI_ICON, Vector(509, 112))

        sprites.icon.wood:draw(DL_UI_ICON, Vector(622, 97))
        self:print(self.right.cost.wood == 0 and "-" or self.right.cost.wood, Vector(488, 94), 126, "right")
        sprites.icon.stone:draw(DL_UI_ICON, Vector(622, 113))
        self:print(self.right.cost.stone == 0 and "-" or self.right.cost.stone, Vector(488, 110), 126, "right")
        sprites.icon.food:draw(DL_UI_ICON, Vector(622, 129))
        self:print(self.right.cost.food == 0 and "-" or self.right.cost.food, Vector(488, 126), 126, "right")
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