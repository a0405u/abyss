local sprites = {}

--- @param filepath string
--- @return Sprite
local function load_from_file(filepath, size, scale, offset)

    local image = love.graphics.newImage(filepath .. ".png")
    if love.filesystem.getInfo(filepath .. ".json") then
        local data = json.decode(love.filesystem.read(filepath .. ".json"))
        return Sprite(image, data, size, scale, offset)
    end
    return Sprite(image, nil, size, scale, offset)
end


--- @param image_data love.ImageData
--- @return love.Image
local function load_from_data(image_data)

    return love.graphics.newImage(image_data)
end


function sprites.load_spritesheet(image)

    Animation.get_frames(image, Vector(image:getHeight(), image:getHeight()), Vector(0, 0), image:getWidth() / image:getHeight())
end


function sprites.load()

    sprites.mouse = load_from_file("sprites/mouse", nil, nil, Vector(0, 0))
    sprites.cursor = load_from_file("sprites/cursor")
    sprites.hand = load_from_file("sprites/hand")
    
    sprites.ui = {
        left = load_from_file("sprites/ui_left", nil, nil, Vector()),
        right = load_from_file("sprites/ui_right", nil, nil, Vector()),
        button = load_from_file("sprites/button", nil, nil, Vector()),
        button_small = load_from_file("sprites/button_small", nil, nil, Vector()),
        button_top = load_from_file("sprites/button_top", nil, nil, Vector()),
        icons = {
            empty = load_from_file("sprites/icon_empty"),
            plank = load_from_file("sprites/icon_plank"),
            block = load_from_file("sprites/icon_block"),
            soil = load_from_file("sprites/icon_soil"),
            house = load_from_file("sprites/icon_house"),
            temple = load_from_file("sprites/icon_temple"),
            townhall = load_from_file("sprites/icon_townhall"),
            mine = load_from_file("sprites/icon_mine"),
            sawmill = load_from_file("sprites/icon_sawmill"),
            windmill = load_from_file("sprites/icon_windmill"),
        },
        icons_small = {
            platform = load_from_file("sprites/icon_small_platform"),
            beam = load_from_file("sprites/icon_small_beam"),
            wall = load_from_file("sprites/icon_small_wall"),
            trees = load_from_file("sprites/icon_small_trees"),
            block = load_from_file("sprites/icon_small_block"),
            soil = load_from_file("sprites/icon_small_soil"),
            wheat = load_from_file("sprites/icon_small_wheat"),
            hammer = load_from_file("sprites/icon_small_hammer"),
            support = load_from_file("sprites/icon_small_support"),
        },
        preview = {
            planks = load_from_file("sprites/preview_planks"),
            block = load_from_file("sprites/preview_block"),
            soil = load_from_file("sprites/preview_soil"),
            support = load_from_file("sprites/preview_support"),
            house = load_from_file("sprites/preview_house"),
            mine = load_from_file("sprites/preview_mine"),
            sawmill = load_from_file("sprites/preview_sawmill"),
            windmill = load_from_file("sprites/preview_windmill"),
            tree = load_from_file("sprites/preview_tree"),
            wheat = load_from_file("sprites/preview_wheat"),
            hammer = load_from_file("sprites/preview_hammer"),
        }
    }
    
    sprites.resources = {
        wood = load_from_file("sprites/wood"),
        stone = load_from_file("sprites/stone"),
        food = load_from_file("sprites/food"),
    }
    
    sprites.screen = {
    
        logo = load_from_file("sprites/logo")
    }
    
    sprites.player = load_from_file("sprites/player")
    sprites.plank = load_from_file("sprites/plank", nil, nil, Vector(14, 7))
    sprites.nail = load_from_file("sprites/nail")
    
    sprites.hill = load_from_file("sprites/hill", nil, nil, Vector(0, 320))
    sprites.hillbg = load_from_file("sprites/hillbg", nil, nil, Vector(0, 320))
    sprites.ground = load_from_file("sprites/ground")
    sprites.background = load_from_file("sprites/background")

    sprites.gib = {
        load_from_file("sprites/gib/scrab_1"),
        load_from_file("sprites/gib/scrab_2"),
        load_from_file("sprites/gib/scrab_3"),
        load_from_file("sprites/gib/scrab_4"),
        load_from_file("sprites/gib/scrab_5"),
        load_from_file("sprites/gib/scrab_6"),
        load_from_file("sprites/gib/scrab_7"),
        load_from_file("sprites/gib/scrab_8"),
        load_from_file("sprites/gib/scrab_9"),
        load_from_file("sprites/gib/scrab_10"),
        load_from_file("sprites/gib/scrab_11"),
        load_from_file("sprites/gib/scrab_12")
    }

    sprites.tiles = {
        tile = load_from_file("sprites/tile"),
        ghost = load_from_file("sprites/tile_ghost"),
        block = {
            load_from_file("sprites/block"),
            load_from_file("sprites/blockb"),
            load_from_file("sprites/blockc"),
            load_from_file("sprites/blockd"),
            load_from_file("sprites/blocke"),
        },
        soil = {
            load_from_file("sprites/soil"),
            load_from_file("sprites/soilb"),
            load_from_file("sprites/soilc")
        },
        support = {
            load_from_file("sprites/support"),
            load_from_file("sprites/supportb"),
            load_from_file("sprites/supportc")
        },
        wheat = {
            load_from_file("sprites/wheat"),
            load_from_file("sprites/wheatb")
        },
        tree = {
            load_from_file("sprites/tree_1"),
            load_from_file("sprites/tree_2"),
            load_from_file("sprites/tree_3")
        }
    }

    sprites.buildings = {
        house = load_from_file("sprites/house"),
        mine = load_from_file("sprites/mine"),
        windmill = load_from_file("sprites/windmill"),
        sawmill = load_from_file("sprites/sawmill"),
        townhall = load_from_file("sprites/townhall"),
        temple = load_from_file("sprites/temple"),
        block = load_from_file("sprites/block"),
        soil = load_from_file("sprites/soil")
    }

    sprites.null = load_from_file("sprites/null")
end

return sprites