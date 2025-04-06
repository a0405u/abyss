local sprites = {}

--- @param filepath string
--- @return love.Image
local function load_from_file(filepath)

    return love.graphics.newImage(filepath .. ".png")
end

--- @param image_data love.ImageData
--- @return love.Image
local function load_from_data(image_data)

    return love.graphics.newImage(image_data)
end


function sprites.load(filepath)

    sprites.load_ui()
    local image = load_from_file("sprites/explosion")
    local frames = Animation.get_frames(image, Vector2(32, 32), Vector2(0, 0), 3)
    local animation = Animation(image, frames, 0.083)
    sprites.explosion = Sprite({idle = animation}, Vector2(1, 1), Vector2(16, 16))

    image = load_from_file("sprites/house_1")
    local file = love.filesystem.newFile("sprites/house_1.json")
    local data = json.decode(file)
    frames = sprites.load_spritesheet(image)
    animation = Animation(image, frames, 0.083)
    sprites.building = Sprite({idle = animation}, Vector2(1, 1), Vector2(image:getWidth() / 2, image:getHeight() / 2))
end


function sprites.load_spritesheet(image)

    Animation.get_frames(image, Vector2(image:getHeight(), image:getHeight()), Vector2(0, 0), image:getWidth() / image:getHeight())
end



function sprites.load_ui()

    sprites.mouse = Sprite(load_from_file("sprites/mouse"))
    sprites.cursor = Sprite(load_from_file("sprites/cursor"))
    sprites.hand = Sprite(load_from_file("sprites/hand"))
    sprites.item_frame = Sprite(load_from_file("sprites/item_frame"))

    sprites.screen = {

        logo = Sprite(load_from_file("sprites/logo"))
    }
end


return sprites