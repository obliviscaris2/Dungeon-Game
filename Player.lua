require 'SpritesandAnimeLoad'
local Timer = require 'libraries/hump/timer'

-- physics.start();

player = {}
player.collider = world:newRectangleCollider(love.graphics.getWidth() / 2, 200, 32, 34, {
    collision_class = 'Player'
})
player.collider:setFixedRotation(true)
player.speed = 20
player.timer = 1
player.highspeed = 300
player.rotation = 0.01

player.isMoving = false
player.canRoll = true
player.isRolling = false
player.isFalling = false
player.inAir = false
player.isGrounded = true
player.isFlapping = false
player.isGliding = false
player.animation = animations.fly
player.direction = 1

function player:update(dt)
    player.flapping = false
    player.inAir = false

    player.isFalling = false

    local pX, pY = player.collider:getPosition()
    player.isGrounded = true

    if player.isRolling == true then
        player.rotation = player.rotation + 0.4

    end

    self:collidercheck(dt)

    if player.direction == 1 then

        self:rollingColliderCheckRight(dt)
    else
        self:rollingColliderCheckLeft(dt)
    end

    self:move(dt)

    self:animationConditions(dt)

end

function player:draw()
    local pX, pY = player.collider:getPosition()

    if player.direction == 1 then

        player.animation:draw(sprites.playerSheet, pX, pY, player.rotation * player.direction, 1.2, nil, 29, 32)

    else
        player.animation:draw(sprites.playerSheet, pX, pY, player.rotation * player.direction, 1.2 * player.direction,
            1.2, 29, 32)
    end

end

function player:move(dt)
    local pX, pY = player.collider:getPosition()
    local px, py = player.collider:getLinearVelocity()

    if love.keyboard.isDown('left') and px > -300 then
        pX = pX - 0.3 * player.speed

    elseif love.keyboard.isDown('right') and px < 300 then
        pX = pX + 0.3 * player.speed
    end

    if love.keyboard.isDown('right') then
        player.collider:setX(pX + 2 * player.speed * dt)
        player.direction = 1
        player.isMoving = true

    elseif love.keyboard.isDown('left') then
        player.collider:setX(pX - 2 * player.speed * dt)
        player.direction = -1
        player.isMoving = true
    end

    -- if love.keyboard.isDown('right') and player.isGrounded == true then
    --         player.collider:setLinearVelocity(0, -250)
    --         player.isMoving = true
    --         player.isRolling = false
    --         player.rotation = 0.01
    -- end

    -- if love.keyboard.isDown('left') and player.isGrounded == true then
    --     player.collider:setLinearVelocity(0, -250)
    --     player.isMoving = true
    --     player.isRolling = false
    --     player.rotation = 0.01
    -- end

end

function player:collidercheck(dt)
    local pX, pY = player.collider:getPosition()
    local colliders = world:queryRectangleArea(pX - 15, pY + 17, 30, 2, {'Platform', 'Wall'})
    if #colliders > 0 then
        player.isGrounded = true
        player.isFalling = false
        player.isGliding = false
        player.isFlapping = false
        player.canRoll = true

    else
        player.inAir = true
        player.isFalling = true
        player.isGrounded = false
        player.isRolling = false
        player.canRoll = false

    end

end

function player:rollingColliderCheckRight(dt)
    local px, py = player.collider:getPosition()
    local colliders = world:queryRectangleArea(px + 15, py, 5, 5, {'Platform'})

    if #colliders > 0 then
        player.isRolling = false
        player.rotation = 0
    end

end

function player:rollingColliderCheckLeft(dt)
    local px, py = player.collider:getPosition()
    local colliders = world:queryRectangleArea(px - 20, py, 5, 5, {'Platform'})

    if #colliders > 0 then
        player.isRolling = false
        player.rotation = 0
    end

end

function player:animationConditions(dt)

    if player.isGrounded == true and player.isFalling == false and player.inAir == false and player.isFlapping == false then

        player.animation = animations.idle

    elseif player.inAir and player.isFlapping == true and player.isFalling == true then
        player.animation = animations.fly

    elseif player.isGrounded == false and player.isFlapping == false then
        player.animation = animations.fly
    end

    if player.isGliding == true then
        player.animation = animations.glide
    end

    if player.isGrounded == true and player.isRolling == true then
        player.animation = animations.roll

    end

end

function love.keypressed(key)
    local pX, pY = player.collider:getPosition()
    player.inAir = false

    if key == 'space' then
        player.isFalling = false
        player.isRolling = false
        player.rotation = 0.01
        player.canRoll = false
        player.inAir = true
        player.isFlapping = true
        player.isGrounded = false
        player.isGliding = false
        Timer.after(0.1, function()
            player.timer = 0
        end)

        -- player.animation = animations.fly
        local topSpeed = -800

        if pY > 0 then
            player.collider:setLinearVelocity(0, -500)
        end
    end

    if player.isGrounded == true and key == 'x' then

        player.isRolling = true
        player.collider:setLinearVelocity(300 * player.direction, 0)
        player.isMoving = true
    end
end

function love.keyreleased(key)
    if key == 'space' then
        player.isFlapping = false
        player.isFalling = true
        if player.isGrounded == false then
            player.isGliding = true

        end
    end
    if key == 'x' then
        player.isRolling = false
        player.rotation = 0.01
    end

end
