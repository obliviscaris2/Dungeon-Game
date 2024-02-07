function love.load()
    math.randomseed(os.time())

    require 'sounds'
    screen = require 'libraries/shack/shack'
    screen:setDimensions(love.graphics.getWidth(), love.graphics.getHeight())

    ------------------------------ALL THE ANIMATION LOADING/CLASSIFYING GOES HERE-----------------------------------
    require 'SpritesandAnimeLoad'

    sti = require 'libraries/Simple-Tiled-Implementation/sti'
    

  
    ------------------------------------------THE PHYSICS WORLD LOADING GOES HERE ----------------------------------------------------
    require 'WorldLoad'

    platforms = {}

    loadMap()
    ------------------------------------------------- IMPORTED PLAYER.LUA/ENEMY.LUA------------------------------------------------------------------
    
    require ('Player')
    require ('Enemy')

    ------------------------------------------------ CREATING GAME OBJECTS --------------------------------------------------------------

    cameraFile = require 'libraries/hump/camera'

    local px, py = player.collider:getPosition()
    
    cam = cameraFile()
    
    cam:zoom(1)


    ---------------------------- LOADING ENEMIES ------------------------------------------------------
    
    allEnemiesLoad()

    blackout = {}
    blackout.timer = 10
    blackout.radius = love.graphics.getWidth()
    --blackout.circle('fill', love.graphics.getWidth()/2, love.graphics.getHeight()/2, blackout.radius)
    
    gameState = 'menu'
    
end



function love.update(dt)

    ---- ### DONE FOR THE SHAKE EFFECT ### -------------------------------------------------------------------------------------------
    screen:update(dt)

    ---- ### BACKGROUND MUSIC ### ----------------------------------------------------------------------------------------------------
    Sounds:play()

    ---- ### PHYSICS WORLD/WILDFIELD UPDATE ### ---------------------------------------------------------------------------------------
    world:update(dt)

    ---- ### LUMINATE EFFECT UPDATE ### ------------------------------------------------------------------------------------------------

    --spawnLuminate:update(dt)

    ---- ### LEVEL 1 GAME MAP UPDATE ### -----------------------------------------------------------------------------------------------
    gameMap:update(dt)

    ---- ### PLAYER CHARACTER UPDATE ----------------------------------------------------------------------------------------------------
    player:update(dt)

    ---- ### PLAYER ANIMATION UPDATE ----------------------------------------------------------------------------------------------------
    player.animation:update(dt)

    ---- ### ALL ENEMIES UPDATE ### ------------------------------------------------------------------------------------------------------
    allEnemiesUpdate(dt)

    ---- ### ALL THE CAMERA WORK GOES HERE ### -------------------------------------------------------------------------------------------
    local px, py = player.collider:getPosition()
    --cam:lookAt(px, love.graphics.getHeight()/2)
    --cam:lookAt(px, py)
    cam:lockWindow(px, py, 500, love.graphics.getWidth() - 500, 0 + 300, love.graphics.getHeight() - 400, cam.smooth.damped(5) ) 

    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()

    if cam.x< w/2 then
        cam.x = w/2
    end

    if cam.y< h/2 then
        cam.y = h/2
    end

    local mapW = gameMap.width * gameMap.tilewidth
    local mapH = gameMap.height * gameMap.tileheight

    if cam.x > (mapW - w/2) then
        cam.x = (mapW - w/2)
    end

    if cam.y > (mapH - h/2) then
        cam.y = (mapH - h/2)
    end

end


function love.draw()

    ---- ### DRAWING THE SCREEN TO SHAKE ### ----------------------------------------------------------------------------------------------
    screen:apply()

    ---- ### TIMER TESTING ### ------------------------------------------------------------------------------------------------------------
    love.graphics.print(luminateEffects.timer)
    
    ---- ### ATTACHING CAM FROM HERE ### --------------------------------------------------------------------------------------------------
    cam:attach()


    drawLuminate()

    
    local sx = love.graphics.getWidth()/sprites.background:getWidth()
    local sy = love.graphics.getHeight()/sprites.background:getHeight()

    --love.graphics.draw(sprites.background, 0, 0, nil, sx, sy )
    --love.graphics.setBackgroundColor(255/255, 183/255, 197/255)

    
    
    gameMap:drawLayer(gameMap.layers['Tile Layer 1'])

    --world:draw()
    player:draw()

    allEnemiesDraw()

    cam:detach()

    
end

function love.mousepressed(x, y, button)
    if button == 1 then
        local colliders = world:queryCircleArea(x, y, 60)
    end
end

function loadMap()
    gameMap = sti('sprites/map/level1.lua')
    for i , obj in pairs(gameMap.layers['Platform'].objects) do 
        SpawnPlatform(obj.x, obj.y, obj.width, obj.height)
    end

end

function SpawnPlatform(x, y, w, h)
    if w > 0 and h > 0 then
        local platform = {}
        platform.collider = world:newRectangleCollider(x, y, w, h, {collision_class = 'Platform'})
        platform.collider:setType('static')
        table.insert(platforms, platform)

    end
end

