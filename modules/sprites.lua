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


function sprites.load(filepath)

    sprites.load_ui()
    sprites.player = load_from_file("sprites/player")
    sprites.plank = load_from_file("sprites/plank", nil, nil, Vector2(14, 7))
    sprites.nail = load_from_file("sprites/nail")
    sprites.building = load_from_file("sprites/house_1")
end


function sprites.load_spritesheet(image)

    Animation.get_frames(image, Vector2(image:getHeight(), image:getHeight()), Vector2(0, 0), image:getWidth() / image:getHeight())
end



function sprites.load_ui()

    sprites.mouse = load_from_file("sprites/mouse", nil, nil, Vector2(0, 0))
    sprites.cursor = load_from_file("sprites/cursor")
    sprites.hand = load_from_file("sprites/hand")
    sprites.item_frame = load_from_file("sprites/item_frame")

    sprites.screen = {

        logo = load_from_file("sprites/logo")
    }
end


return sprites