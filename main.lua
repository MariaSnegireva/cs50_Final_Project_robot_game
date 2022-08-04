require 'code/lib/functionize'
require 'code/src/game'
require 'code/src/player'
require 'code/src/material'
require 'code/src/container'
require 'code/src/director'
require 'code/lib/animation'

function love.load()
    -- canvas

    nativeWindowWidth = 1280
    nativeWindowHeight = 720

    nativeCanvasWidth = 1280
    nativeCanvasHeight = 720

    canvas = love.graphics.newCanvas(nativeCanvasWidth, nativeCanvasHeight)
    canvas:setFilter('linear', 'linear', 2) 
 
    -- assets
    -- fonts
    fonts = {}
    fonts.huge = love.graphics.newFont('assets/fonts/Amatic-Bold.ttf', 228)
    fonts.large = love.graphics.newFont("assets/fonts/Amatic-Bold.ttf", 50)

    -- images
    love.graphics.setDefaultFilter('nearest', 'nearest', 1)

    images = {}
    images.background = love.graphics.newImage("assets/images/space_ground.png")
    images.material = love.graphics.newImage("assets/images/material.png")

    -- animations
    animations= {}
    animations.player = {}
    local frameTime = 0.15

    animations.player.up = newAnimation(love.graphics.newImage("assets/images/character/character_robot_back.png"), 128, 128, frameTime, 4)
    animations.player.down = newAnimation(love.graphics.newImage("assets/images/character/character_robot_idle.png"), 128, 128, frameTime, 4)
    animations.player.left = newAnimation(love.graphics.newImage("assets/images/character/character_robot_left.png"), 128, 128, frameTime, 4)
    animations.player.right = newAnimation(love.graphics.newImage("assets/images/character/character_robot_right.png"), 128, 128, frameTime, 4)

    -- music
    music = {}
    music.main = love.audio.newSource('assets/music/david-bowie-space-oddity.wav', 'stream')
    music.main:setVolume(0.10)
    music.main:setLooping(true)

    -- sounds
    sounds = {}
    sounds.moving = love.audio.newSource('assets/sounds/robot-moving.wav', 'static')
    sounds.moving:setVolume(0.25)
    sounds.material = love.audio.newSource('assets/sounds/coin.wav', 'static')
    sounds.applause = love.audio.newSource('assets/sounds/applause.wav', 'static')

    -- seed random function
    math.randomseed(os.time())

    -- game
    game = Game:new('Menu')
end

function love.update(dt)
    -- determine window scale and offset
    windowScaleX = love.graphics.getWidth() / nativeWindowWidth
    windowScaleY = love.graphics.getHeight() / nativeWindowHeight
    windowScale = math.min(windowScaleX, windowScaleY)
    windowOffsetX = round((windowScaleX - windowScale) * (nativeWindowWidth * 0.5))
    windowOffsetY = round((windowScaleY - windowScale) * (nativeWindowHeight * 0.5))

    -- update game
    game:update(dt)
end


function love.draw()
    -- draw everything to canvas of native size, then upscale and offset
    love.graphics.setCanvas(canvas)
    game:draw()
    love.graphics.setCanvas()
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(canvas, windowOffsetX, windowOffsetY, 0, windowScale, windowScale)

    -- letterboxing
    local windowWidth = love.graphics.getWidth()
    local windowHeight = love.graphics.getHeight()
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle('fill', 0, 0, windowOffsetX, windowHeight)
    love.graphics.rectangle('fill', windowWidth - windowOffsetX, 0, windowOffsetX, windowHeight)
    love.graphics.rectangle('fill', 0, 0, windowWidth, windowOffsetY)
    love.graphics.rectangle('fill', 0, windowHeight - windowOffsetY, windowWidth, windowOffsetY)
end