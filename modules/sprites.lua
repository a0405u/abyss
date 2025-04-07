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
sprites.tile = load_from_file("sprites/tile")
sprites.tile_ghost = load_from_file("sprites/tile_ghost")
sprites.plank = load_from_file("sprites/plank", nil, nil, Vector2(14, 7))
sprites.nail = load_from_file("sprites/nail")
sprites.block = load_from_file("sprites/block")
sprites.soil = load_from_file("sprites/soil")
sprites.hill = load_from_file("sprites/hill", nil, nil, Vector2(0, 320))
sprites.building = load_from_file("sprites/house_1")


return sprites