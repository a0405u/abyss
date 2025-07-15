local audio = {}

function audio.load()

    love.audio.setVolume(config.audio.volume)
end


function audio.volume(v)

    love.audio.setVolume(v)
end

function audio.play(sound, volume, pitch)

    sound = sound:clone()
    if config.audio.enabled then
        if pitch then sound:setPitch(pitch) end
        if volume then sound:setVolume(volume) end
        sound:stop()
        sound:seek(0)
        sound:play()
    end
end


function audio.stop(sound)
    sound:stop()
end


return audio, sound