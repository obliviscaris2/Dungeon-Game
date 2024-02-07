anim8 = require 'libraries/anim8/anim8'

sprites = {}
sprites.background = love.graphics.newImage('sprites/Background/background.png')
sprites.playerSheet = love.graphics.newImage('sprites/Player/player.png')

---- ENEMY SPRITES ------------
sprites.enemyBat = love.graphics.newImage('sprites/enemies/batsheet.png')
sprites.enemyFlame = love.graphics.newImage('sprites/enemies/flameenemysheet.png')
sprites.enemyLanternGhost = love.graphics.newImage('sprites/enemies/lanternenemysheet.png')
sprites.enemyGhost = love.graphics.newImage('sprites/enemies/ghostenemysheet.png')
sprites.enemySkull = love.graphics.newImage('sprites/enemies/skullenemysheet.png')
sprites.enemyPlant = love.graphics.newImage('sprites/enemies/plantenemysheet.png') 
sprites.enemySlime = love.graphics.newImage('sprites/enemies/slimesheet.png')

---- MISC -------------------
sprites.illuminate = love.graphics.newImage('sprites/misc/nade.png')


-- GRID FOR PLAYER ANIMATIONS ------------------------------------------

local grid = anim8.newGrid(64, 64, sprites.playerSheet:getWidth(), sprites.playerSheet:getHeight()) -- flying player

-- PLAYER ANIMATIONS ----------------------------------------------------

animations = {}
animations.idle = anim8.newAnimation(grid('1-2', 1), 0.5)
animations.fly = anim8.newAnimation(grid('1- 5', 1), 0.5)
animations.flap = anim8.newAnimation(grid('1-5', 1), 0.2)
animations.glide = anim8.newAnimation(grid(4, 1), 0.1)
animations.roll = anim8.newAnimation(grid('3-4', 2), 0.5)

-- GRID FOR ENEMY OBJECT ANIMATIONS ----------------------
local batGrid = anim8.newGrid(64, 32, sprites.enemyBat:getWidth(), sprites.enemyBat:getHeight())      -- flying bat
local flameGrid = anim8.newGrid(512, 512, sprites.enemyFlame:getWidth(), sprites.enemyFlame:getHeight())    -- flying blue flame
local lanternGhostGrid = anim8.newGrid(37, 65, sprites.enemyLanternGhost:getWidth(), sprites.enemyLanternGhost:getHeight()) -- flying witch
local ghostGrid = anim8.newGrid(32, 32, sprites.enemyGhost:getWidth(), sprites.enemyGhost:getHeight())  --  wandering whiteghost
local skullGrid = anim8.newGrid(813, 782, sprites.enemySkull:getWidth(), sprites.enemySkull:getHeight())  -- flying skull
local plantGrid = anim8.newGrid(376, 500, sprites.enemyPlant:getWidth(), sprites.enemyPlant:getHeight()) -- emerging plant (He was bullied in school. No! to bullying.
local slimeGrid = anim8.newGrid(64, 32, sprites.enemySlime:getWidth(), sprites.enemySlime:getHeight()) -- Slippytty sloppytty


--- ENEMY ANIMATIONS ------------------------------------------
eAnimations = {}
eAnimations.Bat = anim8.newAnimation(batGrid('1-10', 1), 0.09)
eAnimations.Flame = anim8.newAnimation(flameGrid('1-12', 1), 0.15)
eAnimations.LanternGhost = anim8.newAnimation(lanternGhostGrid('1-4', 1), 0.3)
eAnimations.Ghost = anim8.newAnimation(ghostGrid('1-4', 1), 0.16)
eAnimations.Skull = anim8.newAnimation(skullGrid('1-2', 1), 0.5)
eAnimations.Plant = anim8.newAnimation(plantGrid('1-2', 1), 0.5)
eAnimations.Slime = anim8.newAnimation(slimeGrid('1-10', 1), 0.1)
