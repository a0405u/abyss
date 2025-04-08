local sound = {}


function sound.load()

    sound.jump = love.audio.newSource("sounds/playerstepforest.wav", "static")
    sound.land = love.audio.newSource("sounds/screen.wav", "static")
    sound.deny = love.audio.newSource("sounds/enemystep.wav", "static")
    sound.pick = love.audio.newSource("sounds/select.wav", "static")
    sound.build = love.audio.newSource("sounds/dooropen.wav", "static")
    sound.select = love.audio.newSource("sounds/pick.wav", "static")
    sound.collide = love.audio.newSource("sounds/playerstepground.wav", "static")
    sound.destroy = love.audio.newSource("sounds/death.wav", "static")

    sound.logo = love.audio.newSource("sounds/logo.wav", "static")
    sound.start = love.audio.newSource("sounds/start.wav", "static")
    sound.screen = love.audio.newSource("sounds/screen.wav", "static")
    sound.cycle = love.audio.newSource("sounds/cycle.wav", "static")

    sound.tip = {
        show = love.audio.newSource("sounds/tipshow.wav", "static"),
        hide = love.audio.newSource("sounds/tiphide.wav", "static")
    }
end


return sound