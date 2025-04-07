local sprites = {}

--- @param filepath string
--- @return love.Image
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

    Animation.get_frames(image, Vector2(image:getHeight(), image:getHeight()), Vector2(0, 0), image:getWidth() / image:getHeight())
end


sprites.mouse = load_from_file("sprites/mouse", nil, nil, Vector2(0, 0))
sprites.cursor = load_from_file("sprites/cursor")
sprites.hand = load_from_file("sprites/hand")
sprites.item_frame = load_from_file("sprites/item_frame")

sprites.ui = {
    left = load_from_file("sprites/ui_left"),
    right = load_from_file("sprites/ui_right"),
    button = load_from_file("sprites/button"),
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
    }
}

sprites.icon = {
    wood = load_from_file("sprites/wood"),
    stone = load_from_file("sprites/stone"),
    food = load_from_file("sprites/food"),
}

sprites.screen = {

    logo = load_from_file("sprites/logo")
}

sprites.player = load_from_file("sprites/player")
sprites.plank = load_from_file("sprites/plank", nil, nil, Vector2(14, 7))
sprites.nail = load_from_file("sprites/nail")

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

sprites.tile = load_from_file("sprites/tile")
sprites.tile_ghost = load_from_file("sprites/tile_ghost")
sprites.block = load_from_file("sprites/block")
sprites.soil = load_from_file("sprites/soil")

sprites.hill = load_from_file("sprites/hill", nil, nil, Vector2(0, 320))
sprites.hillbg = load_from_file("sprites/hillbg", nil, nil, Vector2(0, 320))
sprites.background = load_from_file("sprites/background")

sprites.building = load_from_file("sprites/house_1")
sprites.house = load_from_file("sprites/house")
sprites.mine = load_from_file("sprites/mine")
sprites.windmill = load_from_file("sprites/windmill")
sprites.sawmill = load_from_file("sprites/sawmill")
sprites.townhall = load_from_file("sprites/townhall")
sprites.temple = load_from_file("sprites/temple")



return sprites