Sounds = {}
Sounds.bgm = love.audio.newSource('sounds/bgm.mp3', 'stream')




function Sounds:play()
    Sounds.bgm:play()
end