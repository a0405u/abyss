-- #TODO Json
local config = {}

config.physics = {
    scale = 1
}

config.theme = {
    palette = "sprites/palette.png"
}

config.screen = {
    scale = (DEBUG and 3) or 2,
    width = 640,
    height = 360,
    title = "abyss",
    filtermode = "nearest",
    linestyle = "rough",
    borderless = true,
    fullscreen = false,
    os_mouse_visibility = false,
}

config.audio = {
    enabled = true,
    volume = 0.1,
}

config.debug = {
    fps = true,
}

config.input = {
    keyrepeat = false,
    up = "w",
    down = "s",
    left = "a",
    right = "d",
    a = "j",
    b = "k",
    x = "l",
    y = "i",
    back = "escape",
    start = "enter",
    select = "space",
    one = "1",
    two = "2",
    three = "3",
}

return config