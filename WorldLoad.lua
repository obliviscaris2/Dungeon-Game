wf = require 'libraries/windfield/windfield'
math.randomseed(os.time())

world = wf.newWorld(0, 0, false)
world:setGravity(0, 1500)
world:setQueryDebugDrawing(true)

-- ADDING/DEFINING COLLISION CLASS
world:addCollisionClass('Player')
world:addCollisionClass('Platform')
world:addCollisionClass('Danger')
world:addCollisionClass('Wall', {ignores = {'Player'}})
world:addCollisionClass('EnemyPlatform')
world:addCollisionClass('Effects', {ignores = {'Platform', 'Player'}})

local EnemyPlatforms = {}

function spawnEnemyPlatform(x, y, w, h)
    local platform = {}
    platform.collider = world:newRectangleCollider(x, y, w, h, {collision_class = 'EnemyPlatform'})
    platform.collider:setType('static')
    table.insert(EnemyPlatforms, platform)
end


luminateEffects = {}
luminateEffects.spawnTime = math.random(5,  10)
luminateEffects.timer = luminateEffects.spawnTime 


function spawnLuminate()
    effect = {}
    local px, py = player.collider:getPosition()
    local x = px + math.random(-200, 500)
    local y = py + math.random(-500, 500)

    effect.collider = world:newRectangleCollider(x, y, 20, 20, {collision_class = 'Effects'})
    effect.collider:setType('dynamic')
        
    table.insert(luminateEffects, effect)

end

--function spawnLuminate:update(dt)
    
   -- luminateEffects.spawnTime = math.random(5,  10)
    

   -- luminateEffects.timer = luminateEffects.timer - dt

   -- if luminateEffects.timer < 0 then
    --    createLuminate()
   --     luminateEffects.timer = luminateEffects.spawnTime
        
    ----end

--end

function drawLuminate()
    for i , objs in ipairs(luminateEffects) do
        local olx, oly = objs:getPosition()
        love.graphics.draw(sprites.illuminate, olx, oly, nil, nil, nil, 15, 15 )
    end
end