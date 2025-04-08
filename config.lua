-- #TODO Json
local config = {}

function config:load()

    self.physics = {
        scale = 1
    }
    
    self.theme = {
        palette = "sprites/palette.png"
    }
    
    self.screen = {
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
    
    self.audio = {
        enabled = true,
        volume = 0.5,
    }
    
    self.debug = {
        fps = true,
    }
    
    self.input = {
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
end

return config