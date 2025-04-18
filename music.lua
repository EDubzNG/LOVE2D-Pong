local cbtMusic = love.audio.newSource("assets/cbt.mp3", "stream")

function playMusic()
    local isPlaying = false
    if isPlaying == false then
        cbtMusic:play()
        cbtMusic:setLooping(true)
        isPlaying = true
    end
end