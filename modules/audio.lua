local audio = {}

function audio.load()

    love.audio.setVolume(config.audio.volume)
end

function audio.play(sound)

    if config.audio.enabled then
        sound:stop()
        sound:seek(0)
        sound:play()
    end
end


function audio.stop(sound)
    sound:stop()
end


return audio, sound