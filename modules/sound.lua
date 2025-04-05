local sound = {}


function sound.load()

    sound.menu = {
        pick = love.audio.newSource("sounds/pick.wav", "static"),
        select = love.audio.newSource("sounds/select.wav", "static"),
    }

    sound.player = {}
    sound.player.step = {
        ground = love.audio.newSource("sounds/playerstepground.wav", "static"),
        forest = love.audio.newSource("sounds/playerstepforest.wav", "static"),
        building = love.audio.newSource("sounds/playerstepbuilding.wav", "static"),
        water = love.audio.newSource("sounds/playerstepwater.wav", "static")
    }

    sound.monster = {
        step = love.audio.newSource("sounds/enemystep.wav", "static")
    }

    sound.door = {
        open = love.audio.newSource("sounds/dooropen.wav", "static"),
        closed = love.audio.newSource("sounds/doorclosed.wav", "static")
    }

    sound.pickup = love.audio.newSource("sounds/pickup.wav", "static")

    sound.death = love.audio.newSource("sounds/death.wav", "static")

    sound.shot = love.audio.newSource("sounds/shot.wav", "static")
    sound.last = love.audio.newSource("sounds/end.wav", "static")

    sound.intro = love.audio.newSource("sounds/intro.wav", "static")
    sound.intro:setLooping(true)

    sound.logo = love.audio.newSource("sounds/logo.wav", "static")
    sound.start = love.audio.newSource("sounds/start.wav", "static")
    sound.screen = love.audio.newSource("sounds/screen.wav", "static")
    sound.cycle = love.audio.newSource("sounds/cycle.wav", "static")

    sound.pick = love.audio.newSource("sounds/pick.wav", "static")

    sound.tip = {
        show = love.audio.newSource("sounds/tipshow.wav", "static"),
        hide = love.audio.newSource("sounds/tiphide.wav", "static")
    }
end


return sound