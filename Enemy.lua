-------------------------------------------------------------------------SUMMARY ------------------------------------------------------------------

function allEnemiesLoad()
    --spawnPlantEnemy(180, 650)
    --spawnBatEnemy(180, 100)
    --spawnFlameEnemy(180, 100)
    --spawnLanternEnemy(180, 100)
    --spawnSkullEnemy(180, 100)
    --spawnGhostEnemy(180, 100)
    spawnSlimeEnemy(180, 750)
    --spawnPlantEnemy(180, 100)


end

function allEnemiesUpdate(dt)
    updatePlantEnemy(dt)
    updateBatEnemy(dt)
    updateFlameEnemy(dt)
    updateLanternEnemy(dt)
    updateSkullEnemy(dt)
    updateGhostEnemy(dt)
    updateSlimeEnemy(dt)

end

function allEnemiesDraw()
    --drawPlantEnemy()
    drawBatEnemy()
    --drawFlameEnemy()
    --drawLanternEnemy()
    --drawSkullEnemy()
    --drawGhostEnemy()
    drawSlimeEnemy()

end

------------------------------------------------------------------------FIN~-----------------------------------------------------------------------

------------------------------------------------------------------ ENEMYCODE CHUNKS --------------------------------------------------------------
PlantEnemies = {}
function spawnPlantEnemy(x, y)
    local enemy = world:newRectangleCollider(x, y, 35, 50, {collision_class = 'Danger'})
    enemy.direction = 1
    enemy.speed = 100
    enemy.animation = eAnimations.Plant
    table.insert(PlantEnemies, enemy)
end

function updatePlantEnemy(dt)
    for i, e in ipairs(PlantEnemies) do
        eAnimations.Plant:update(dt)
        local ex, ey = e:getPosition()

        local colliders = world:queryRectangleArea(ex + (15 * e.direction), ey + 20, 10, 10, {'Platform'})
        if #colliders == 0 then
            e.direction = e.direction * -1
        end
        e:setX(ex + e.speed * dt * e.direction) 
    end
end

function drawPlantEnemy()
    for i, e in ipairs(PlantEnemies) do
        local ex, ey = e:getPosition()
        if e.direction == 1 then
            eAnimations.Plant:draw(sprites.enemyPlant, ex, ey, nil, 0.12 * -1, 0.12, 180 , 260)
        else 
            eAnimations.Plant:draw(sprites.enemyPlant, ex, ey, nil, 0.12, nil, 180, 260)
        end
    end
end
----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------

BatEnemies = {}

function spawnBatEnemy(x, y)
    local enemy = world:newRectangleCollider(x, y, 40, 20, {collision_class = 'Danger'})
    enemy.direction = 1
    enemy.speed = 100
    enemy.animation = eAnimations.Bat
    table.insert(BatEnemies, enemy)
end

function updateBatEnemy(dt)
    for i, b in ipairs(BatEnemies) do 
        eAnimations.Bat:update(dt)
        local bx, by = b:getPosition()

        local colliders = world:queryRectangleArea(bx + (12 * b.direction), by + 8, 10, 10, {'Platform'})
        if #colliders == 0 then
            b.direction = b.direction * -1
        end
        b:setX(bx + b.speed * dt * b.direction)
    end
end

function drawBatEnemy()
    for i, b in ipairs(BatEnemies) do
        local bx, by = b:getPosition()
        if b.direction == 1 then
            eAnimations.Bat:draw(sprites.enemyBat, bx, by, nil, 1.8, nil, 32, 16 )
        else
            eAnimations.Bat:draw(sprites.enemyBat, bx, by, nil, 1.8 * b.direction, 1.8, 32, 16 )
        end
    end
end

----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------

FlameEnemies = {}

function spawnFlameEnemy(x, y)
    local enemy = world:newRectangleCollider(x, y, 45, 40, {collision_class = 'Danger'})
    enemy.direction = 1
    enemy.speed = 100
    enemy.rotation = 0
    enemy.animation = eAnimations.Flame
    table.insert(FlameEnemies, enemy)
end

function updateFlameEnemy(dt)
    for i, f in ipairs(FlameEnemies) do 
        eAnimations.Flame:update(dt)
        local fx, fy = f:getPosition()
        f.rotation = f.rotation + 1  * 0.1 * f.direction

        local colliders = world:queryRectangleArea(fx + (15 * f.direction), fy + 20, 10, 10, {'Platform'})
        if #colliders == 0 then
            f.direction = f.direction * -1
            f.rotation = f.rotation * -1
        end
        f:setX(fx + f.speed * dt * f.direction)

    end
end

function drawFlameEnemy()
    for i, f in ipairs(FlameEnemies) do
        local fx, fy = f:getPosition()
        if f.direction == 1 then
            eAnimations.Flame:draw(sprites.enemyFlame, fx, fy, nil, 0.2, nil, 260, 315)
        else
            eAnimations.Flame:draw(sprites.enemyFlame, fx, fy, nil, 0.2, nil, 260, 315)
        end
    end
end

----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------

LanternEnemies = {}

function spawnLanternEnemy(x, y)
    local enemy = world:newRectangleCollider(x, y, 30, 65, {collision_class = 'Danger'})
    enemy.direction = 1
    enemy.speed = 100
    enemy.animation = eAnimations.LanternGhost
    table.insert(LanternEnemies, enemy)
end

function updateLanternEnemy(dt)
    for i, l in ipairs(LanternEnemies) do 
        eAnimations.LanternGhost:update(dt)
        local lx, ly = l:getPosition()

        local colliders = world:queryRectangleArea(lx + (12 * l.direction), ly + 30, 10, 10, {'Platform'})
        if #colliders == 0 then
            l.direction = l.direction * -1
        end
        l:setX(lx + l.speed * dt * l.direction)

    end
end

function drawLanternEnemy()
    for i, l in ipairs(LanternEnemies) do
        local lx, ly = l:getPosition()
        if l.direction == 1 then
            eAnimations.LanternGhost:draw(sprites.enemyLanternGhost, lx, ly, nil, 1.5, nil, 15, 35)
        else
            eAnimations.LanternGhost:draw(sprites.enemyLanternGhost, lx, ly, nil, 1.5 * l.direction, 1.5, 15, 35)
        end
    end
end

----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------

SkullEnemies = {}

function spawnSkullEnemy(x, y)
    local enemy = world:newRectangleCollider(x, y, 30, 30, {collision_class = 'Danger'})
    enemy.direction = 1
    enemy.speed = 100
    enemy.animation = eAnimations.Skull
    table.insert(SkullEnemies, enemy)

end

function updateSkullEnemy(dt)
    for i, s in ipairs(SkullEnemies) do 
        eAnimations.Skull:update(dt)
        local sx, sy = s:getPosition()

        local colliders = world:queryRectangleArea(sx + (12 * s.direction), sy + 12, 10, 10, {'Platform'})
        if #colliders == 0 then
            s.direction = s.direction * -1
        end
        s:setX(sx + s.speed * dt * s.direction)

    end
end

function drawSkullEnemy()
    for i, s in ipairs(SkullEnemies) do
        local sx, sy = s:getPosition()
        if s.direction == 1 then
            eAnimations.Skull:draw(sprites.enemySkull, sx, sy, nil, 0.05 * s.direction * -1 , 0.05, 400, 370)
            
        else
            eAnimations.Skull:draw(sprites.enemySkull, sx, sy, nil, 0.05, 0.05, 400, 370)
        end
    end
end

----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------

GhostEnemies = {}

function spawnGhostEnemy(x, y)
    local enemy = world:newRectangleCollider(x, y, 20, 20, {collision_class = 'Danger'})
    enemy.direction = 1
    enemy.speed = 100
    enemy.animation = eAnimations.Ghost
    table.insert(GhostEnemies, enemy)

end

function updateGhostEnemy(dt)
    for i, g in ipairs(GhostEnemies) do 
        eAnimations.Ghost:update(dt)
        local gx, gy = g:getPosition()

        local colliders = world:queryRectangleArea(gx  + (8 * g.direction), gy + 6, 5 , 5,  {'Platform'})
        if #colliders == 0 then
            g.direction = g.direction * -1
        end
        g:setX(gx + g.speed * dt * g.direction)

    end
end

function drawGhostEnemy()
    for i, g in ipairs(GhostEnemies) do
        local gx, gy = g:getPosition()
        if g.direction == 1 then
            eAnimations.Ghost:draw(sprites.enemyGhost, gx, gy, nil, nil, nil, 16, 15) -- GHOST !!
            
        else
            eAnimations.Ghost:draw(sprites.enemyGhost, gx, gy, nil, nil, nil, 16, 15) -- GHOST !!
        end
    end
end

----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------

SlimeEnemies = {}

function spawnSlimeEnemy(x, y)
    local enemy = world:newRectangleCollider(x, y, 30, 25, {collision_class = 'Danger'})
    enemy.direction = 1
    enemy.speed = 100
    enemy.animation = eAnimations.Slime
    table.insert(SlimeEnemies, enemy)

end

function updateSlimeEnemy(dt)
    for i, sl in ipairs(SlimeEnemies) do 
        eAnimations.Slime:update(dt)
        local slx, sly = sl:getPosition()

        local colliders = world:queryRectangleArea(slx  + (8 * sl.direction), sly + 6, 10, 10,  {'Platform'})
        if #colliders == 0 then
            sl.direction = sl.direction * -1
        end
        sl:setX(slx + sl.speed * dt * sl.direction)

    end
end

function drawSlimeEnemy()
    for i, sl in ipairs(SlimeEnemies) do
        local slx, sly = sl:getPosition()
        if sl.direction == 1 then
            eAnimations.Slime:draw(sprites.enemySlime, slx, sly, nil, 1.5, nil, 38, 20)
            
        else
            eAnimations.Slime:draw(sprites.enemySlime, slx, sly, nil, 1.5 * sl.direction, 1.5, 38, 20)
        end
    end
end

