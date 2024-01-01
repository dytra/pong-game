
-- Define initial variables
local ball = { x = 400, y = 300, radius = 10, speed = 200, dx=1, dy=1}
local paddle1 = {x = 50, y = 250, width= 10, height= 100, speed = 200}
local paddle2 = { x = 740, y = 250, width=10,height=100,speed= 200}

-- Load function (Love2D callback)
function love.load()
    love.window.setTitle("Pong Game")
    love.window.setMode(800, 600, {resizable=false})
end

-- Update function (Love2D callback)
function love.update(dt)
    -- Move paddles
    if love.keyboard.isDown("w") and paddle1.y > 0 then
        paddle1.y = paddle1.y - paddle1.speed * dt
    end
    if love.keyboard.isDown("s") and paddle1.y < love.graphics.getHeight() - paddle1.height then
        paddle1.y = paddle1.y + paddle1.speed * dt
    end

    if love.keyboard.isDown("up") and paddle2.y > 0 then
        paddle2.y = paddle2.y - paddle2.speed * dt
    end
    if love.keyboard.isDown("down") and paddle2.y < love.graphics.getHeight() - paddle2.height then
        paddle2.y = paddle2.y + paddle2.speed * dt
    end

    -- Move ball
    ball.x = ball.x + ball.speed * ball.dx * dt
    ball.y = ball.y + ball.speed * ball.dy * dt

    -- Reflect ball off walls
    if ball.y - ball.radius < 0 or ball.y + ball.radius > love.graphics.getHeight() then
        ball.dy = -ball.dy
    end

    -- Check collision with paddles
    if ball.x - ball.radius < paddle1.x + paddle1.width and
       ball.y > paddle1.y and
       ball.y < paddle1.y + paddle1.height then
        ball.dx = -ball.dx
    end

    if ball.x + ball.radius > paddle2.x and
       ball.y > paddle2.y and
       ball.y < paddle2.y + paddle2.height then
        ball.dx = -ball.dx
    end

    -- Check if the ball goes out of bounds
    if ball.x - ball.radius < 0 or ball.x + ball.radius > love.graphics.getWidth() then
        -- Reset ball position
        ball.x = love.graphics.getWidth() / 2
        ball.y = love.graphics.getHeight() / 2
    end
end

-- Draw function (Love2D callback)
function love.draw()
    -- Draw paddles
    love.graphics.rectangle("fill", paddle1.x, paddle1.y, paddle1.width, paddle1.height)
    love.graphics.rectangle("fill", paddle2.x, paddle2.y, paddle2.width, paddle2.height)

    -- Draw ball
    love.graphics.circle("fill", ball.x, ball.y, ball.radius)
end