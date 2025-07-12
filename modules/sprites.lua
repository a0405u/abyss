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

    sprites.ui = {
        mouse = load_from_file("sprites/ui/mouse", nil, nil, Vector(0, 0)),
        left = load_from_file("sprites/ui/left", nil, nil, Vector()),
        right = load_from_file("sprites/ui/right", nil, nil, Vector()),
        button = load_from_file("sprites/ui/buttons/medium", nil, nil, Vector()),
        button_small = load_from_file("sprites/ui/buttons/small", nil, nil, Vector()),
        button_top = load_from_file("sprites/ui/buttons/top", nil, nil, Vector()),
        icons = {
            empty = load_from_file("sprites/ui/icons/empty"),
            plank = load_from_file("sprites/ui/icons/plank"),
            block = load_from_file("sprites/ui/icons/block"),
            soil = load_from_file("sprites/ui/icons/soil"),
            house = load_from_file("sprites/ui/icons/house"),
            temple = load_from_file("sprites/ui/icons/temple"),
            townhall = load_from_file("sprites/ui/icons/townhall"),
            mine = load_from_file("sprites/ui/icons/mine"),
            sawmill = load_from_file("sprites/ui/icons/sawmill"),
            windmill = load_from_file("sprites/ui/icons/windmill"),
        },
        icons_small = {
            platform = load_from_file("sprites/ui/icons/small/platform"),
            beam = load_from_file("sprites/ui/icons/small/beam"),
            wall = load_from_file("sprites/ui/icons/small/wall"),
            trees = load_from_file("sprites/ui/icons/small/trees"),
            block = load_from_file("sprites/ui/icons/small/block"),
            soil = load_from_file("sprites/ui/icons/small/soil"),
            wheat = load_from_file("sprites/ui/icons/small/wheat"),
            hammer = load_from_file("sprites/ui/icons/small/hammer"),
            support = load_from_file("sprites/ui/icons/small/support"),
        },
        preview = {
            planks = load_from_file("sprites/ui/preview/planks"),
            block = load_from_file("sprites/ui/preview/block"),
            soil = load_from_file("sprites/ui/preview/soil"),
            support = load_from_file("sprites/ui/preview/support"),
            house = load_from_file("sprites/ui/preview/house"),
            mine = load_from_file("sprites/ui/preview/mine"),
            sawmill = load_from_file("sprites/ui/preview/sawmill"),
            windmill = load_from_file("sprites/ui/preview/windmill"),
            tree = load_from_file("sprites/ui/preview/tree"),
            wheat = load_from_file("sprites/ui/preview/wheat"),
            hammer = load_from_file("sprites/ui/preview/hammer"),
        }
    }
    
    sprites.resources = {
        wood = load_from_file("sprites/ui/resources/wood"),
        stone = load_from_file("sprites/ui/resources/stone"),
        food = load_from_file("sprites/ui/resources/food"),
    }
    
    sprites.screen = {
    
        logo = load_from_file("sprites/logo")
    }
    
    sprites.player = load_from_file("sprites/player/player")
    sprites.plank = load_from_file("sprites/plank/plank", nil, nil, Vector(14, 7))
    sprites.nail = load_from_file("sprites/plank/nail")
    
    sprites.hill = load_from_file("sprites/map/hill", nil, nil, Vector(0, 320))
    sprites.hillbg = load_from_file("sprites/map/hillbg", nil, nil, Vector(0, 320))
    sprites.ground = load_from_file("sprites/map/ground")
    sprites.background = load_from_file("sprites/map/background")

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
        tile = load_from_file("sprites/tiles/tile"),
        ghost = load_from_file("sprites/tiles/ghost"),
        block = {
            load_from_file("sprites/tiles/block"),
            load_from_file("sprites/tiles/blockb"),
            load_from_file("sprites/tiles/blockc"),
            load_from_file("sprites/tiles/blockd"),
            load_from_file("sprites/tiles/blocke"),
        },
        soil = {
            load_from_file("sprites/tiles/soil"),
            load_from_file("sprites/tiles/soilb"),
            load_from_file("sprites/tiles/soilc")
        },
        support = {
            load_from_file("sprites/tiles/support"),
            load_from_file("sprites/tiles/supportb"),
            load_from_file("sprites/tiles/supportc")
        },
        wheat = {
            load_from_file("sprites/tiles/wheat"),
            load_from_file("sprites/tiles/wheatb")
        },
        tree = {
            load_from_file("sprites/tiles/tree_1"),
            load_from_file("sprites/tiles/tree_2"),
            load_from_file("sprites/tiles/tree_3")
        }
    }

    sprites.buildings = {
        house = load_from_file("sprites/buildings/house"),
        mine = load_from_file("sprites/buildings/mine"),
        windmill = load_from_file("sprites/buildings/windmill"),
        sawmill = load_from_file("sprites/buildings/sawmill"),
        townhall = load_from_file("sprites/buildings/townhall"),
        temple = load_from_file("sprites/buildings/temple"),
        block = load_from_file("sprites/buildings/block"),
        soil = load_from_file("sprites/buildings/soil"),
        support = load_from_file("sprites/buildings/support"),
        arch = load_from_file("sprites/buildings/arch"),
        arcade = load_from_file("sprites/buildings/arcade"),
    }

    sprites.null = load_from_file("sprites/null")
end

return sprites