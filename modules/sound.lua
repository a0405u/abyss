local sound = {}


function sound.load()

    sound.jump = sound.from_file("sounds/playerstepforest.wav")
    sound.land = sound.from_file("sounds/screen.wav")
    sound.deny = sound.from_file("sounds/enemystep.wav")
    sound.pick = sound.from_file("sounds/select.wav")
    sound.build = sound.from_file("sounds/dooropen.wav")
    sound.select = sound.from_file("sounds/pick.wav")
    sound.collide = sound.from_file("sounds/playerstepground.wav")
    sound.destroy = {
        block = sound.from_file("sounds/destroyf.wav"),
        building = sound.from_file("sounds/destroyf.wav"),
        plank = sound.from_file("sounds/destroyg.wav"),
        gib = sound.from_file("sounds/hita.wav"),
        nail = sound.from_file("sounds/naila.wav")
    }
    sound.hit = {
        block = sound.from_file("sounds/hit.wav"),
        building = sound.from_file("sounds/hit.wav"),
        plank = sound.from_file("sounds/hitb.wav"),
        gib = sound.from_file("sounds/hit.wav"),
    }
    sound.sink = {
        block = sound.from_file("sounds/sinkd.wav", 0.4),
        building = sound.from_file("sounds/sinkd.wav", 0.4),
        plank = sound.from_file("sounds/sinkd.wav", 0.4),
        gib = sound.from_file("sounds/sinkd.wav", 0.4),
    }
    sound.hint = sound.from_file("sounds/playerstepwater.wav")

    sound.logo = sound.from_file("sounds/logo.wav")
    sound.start = sound.from_file("sounds/start.wav")
    sound.screen = sound.from_file("sounds/screen.wav")
    sound.cycle = sound.from_file("sounds/cycle.wav")

    sound.tip = {
        show = sound.from_file("sounds/tipshow.wav"),
        hide = sound.from_file("sounds/tiphide.wav"),
    }
end


function sound.from_file(filepath, volume)

    local s = love.audio.newSource(filepath, "static")
    s:setVolume(volume or 1)
    return s
end


return sound