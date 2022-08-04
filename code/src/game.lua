local class = require 'code/lib/middleclass'
local stateful = require 'code/lib/stateful'

Game = class('Game')
Game:include(stateful)

function Game:initialize(state)
    self:gotoState(state)
end

Menu = Game:addState('Menu')
Play = Game:addState('Play')
SpaceOver = Game:addState('SpaceOver')

-- Menu

function Menu:update(dt)
    -- start the game when the player presses a key
    if love.keyboard.isDown('space', 'return', 'up', 'down', 'left', 'right', 'w', 's', 'a', 'd') then
        self:gotoState('Play')
        return
    end
end

function Menu:draw()
    -- draw background
    love.graphics.setColor(255, 255, 255)
    local w = images.background:getWidth()
    local h = images.background:getHeight()
    for x = 0, nativeCanvasWidth, w do
        for y = 0, nativeCanvasHeight, h do
            love.graphics.draw(images.background, x, y)
        end
    end

    -- draw title
    love.graphics.setFont(fonts.huge)
    love.graphics.setColor(255, 255, 255)
    love.graphics.printf('Isaac Asimov Legacy', nativeCanvasWidth / 2 - 500, nativeCanvasHeight / 2 - 200, 1000, 'center')

    -- press start
    if math.cos(2 * math.pi * love.timer.getTime()) > 0 then
        love.graphics.setFont(fonts.large)
        love.graphics.setColor(255, 255, 255)
        love.graphics.printf('START YOUR OWN UNIVERSE', nativeCanvasWidth / 2 - 500, nativeCanvasHeight / 2 + 50, 1000, 'center')
    end
end

-- Play

function Play:enteredState()
    -- music
    music.main:play()

    self.player = Player:new()
    self.director = Director:new()
    self.materials = Container:new()

    -- score
    self.score = 0

    -- timer
    self.timeLeft = 30
end

function Play:update(dt)
    self.player:update(dt)
    self.director:update(dt)
    self.materials:update(dt)

    -- update timer
    self.timeLeft = self.timeLeft - dt
    if self.timeLeft < 0 then
        self:gotoState('SpaceOver')
        return
    end

    -- back to menu
    if love.keyboard.isDown('escape') then
        self:gotoState('Menu')
        return
    end
end

function Play:draw()
    -- draw background
    love.graphics.setColor(255, 255, 255)
    local w = images.background:getWidth()
    local h = images.background:getHeight()
    for x = 0, nativeCanvasWidth, w do
        for y = 0, nativeCanvasHeight, h do
            love.graphics.draw(images.background, x, y)
        end
    end

    self.materials:draw()
    self.player:draw()

    -- print score
    love.graphics.setFont(fonts.large)
    love.graphics.setColor(255, 255, 255)
    love.graphics.printf("Collected:" ..self.score, nativeCanvasWidth - 1000 - 20, 0, 1000, 'right')

    -- print timer
    love.graphics.setFont(fonts.large)
    love.graphics.setColor(255, 255, 255)
    local seconds = round(self.timeLeft)
    if seconds < 10 then
        if math.cos(self.timeLeft * 12) > 0 then
            love.graphics.printf('0:0' .. seconds, 20, 0, 1000, 'left')
        end
    else
        love.graphics.printf('0:' .. seconds, 20, 0, 1000, 'left')
    end
end

function Play:exitedState()
    -- music
    music.main:stop()
end

-- SpaceOver

function SpaceOver:enteredState()
    -- sound effect
    sounds.applause:play()

    -- timer
    self.initTime = love.timer.getTime()
end

function SpaceOver:update(dt)
    -- go back to menu after 10 seconds
    if love.timer.getTime() - self.initTime > 10 then
        self:gotoState('Menu')
        return
    end

    -- back to menu
    if love.keyboard.isDown('escape') then
        self:gotoState('Menu')
        return
    end
end

function SpaceOver:draw()
    -- draw background
    love.graphics.setColor(255, 255, 255)
    local w = images.background:getWidth()
    local h = images.background:getHeight()
    for x = 0, nativeCanvasWidth, w do
        for y = 0, nativeCanvasHeight, h do
            love.graphics.draw(images.background, x, y)
        end
    end

    -- print score
    love.graphics.setFont(fonts.large)
    love.graphics.setColor(255, 255, 255)
    if self.score >= 5 then
        love.graphics.printf("Good job! You found " .. self.score .. " minerals!", nativeCanvasWidth / 2 - 500, nativeCanvasHeight / 2 - 100, 1000, 'center')
    else 
        love.graphics.printf("SPACE OVER... You found " .. self.score .. " minerals. This is not enough!", nativeCanvasWidth / 2 - 500, nativeCanvasHeight / 2 - 200, 1000, 'center')
    end

end

function SpaceOver:exitedState()
    -- sound effect
    sounds.applause:stop()
end