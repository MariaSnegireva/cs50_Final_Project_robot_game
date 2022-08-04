local class = require 'code/lib/middleclass'

Material = class('Material')

function Material:initialize(x, y)
    self.x = x
    self.y = y

    self.radius = 28

    self.timeToLive = 6.5
end

function Material:update(dt)
    -- check if player is touching
    local dx = game.player.x - self.x
    local dy = game.player.y - self.y
    local d = math.sqrt(dx ^ 2 + dy ^ 2)
    if d < self.radius + game.player.radius then
        -- score
        game.score = game.score + 1

        -- sfx
        sounds.material:stop()
        sounds.material:play()

        self.to_delete = true
    end

    self.timeToLive = self.timeToLive - dt

    -- check for timeout
    if self.timeToLive < 0 then
        self.to_delete = true
    end
end

function Material:draw()
    -- make coin flash when it's about to disappear
    if self.timeToLive > 1.5 or math.sin(5 * self.timeToLive * 2 * math.pi) > 0 then
        love.graphics.setColor(255, 255, 255)
        love.graphics.draw(images.material, self.x, self.y, 0, 1, 1, 28, 28)
    end
end