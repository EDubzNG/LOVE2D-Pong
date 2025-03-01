-- Window dimensions
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- Paddle dimensions
PADDLE_WIDTH = 20
PADDLE_HEIGHT = 100
PADDLE_SPEED = 500

-- Ball dimensions
BALL_SIZE = 20

-- Game state
gameState = 'title'

-- Require title screen and score
require 'title'
require 'score'

-- Load function
function love.load()
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    -- Load title screen
    titleLoad()

    -- Initialize paddles
    player1Y = 30
    player2Y = WINDOW_HEIGHT - 30 - PADDLE_HEIGHT

    -- Initialize ball
    resetBall()

    -- Initialize scores
    resetScores()

    -- Set font for scores
    scoreFont = love.graphics.newFont(32)
end

-- Function to reset the ball to the center with random velocity
function resetBall()
    ballX = WINDOW_WIDTH / 2 - BALL_SIZE / 2
    ballY = WINDOW_HEIGHT / 2 - BALL_SIZE / 2
    ballDX = math.random(2) == 1 and 200 or -200
    ballDY = math.random(-100, 100)
end

-- Update function
function love.update(dt)
    if gameState == 'title' then
        titleUpdate(dt)
    elseif gameState == 'play' then
        -- Player 1 movement
        if love.keyboard.isDown('w') then
            player1Y = math.max(0, player1Y - PADDLE_SPEED * dt)
        elseif love.keyboard.isDown('s') then
            player1Y = math.min(WINDOW_HEIGHT - PADDLE_HEIGHT, player1Y + PADDLE_SPEED * dt)
        end

        -- Player 2 (AI) movement with delay and reduced speed
        local aiSpeed = PADDLE_SPEED * 0.8 -- AI paddle speed (slower than player)
        local aiThreshold = 20 -- Threshold to reduce jitter
        local aiReactionTime = 0.4 -- AI reaction time delay

        if ballY + BALL_SIZE / 2 < player2Y + PADDLE_HEIGHT / 2 - aiThreshold then
            player2Y = math.max(0, player2Y - aiSpeed * dt * aiReactionTime)
        elseif ballY + BALL_SIZE / 2 > player2Y + PADDLE_HEIGHT / 2 + aiThreshold then
            player2Y = math.min(WINDOW_HEIGHT - PADDLE_HEIGHT, player2Y + aiSpeed * dt * aiReactionTime)
        end

        -- Ball movement
        ballX = ballX + ballDX * dt
        ballY = ballY + ballDY * dt

        -- Ball collision with top and bottom
        if ballY <= 0 then
            ballY = 0
            ballDY = -ballDY
        elseif ballY >= WINDOW_HEIGHT - BALL_SIZE then
            ballY = WINDOW_HEIGHT - BALL_SIZE
            ballDY = -ballDY
        end

        -- Ball collision with paddles
        if ballX <= PADDLE_WIDTH and ballY + BALL_SIZE >= player1Y and ballY <= player1Y + PADDLE_HEIGHT then
            ballX = PADDLE_WIDTH
            ballDX = -ballDX * 1.1 -- Increase speed slightly
            ballDY = ballDY + math.random(-50, 50) -- Add randomness to vertical velocity
        end

        if ballX >= WINDOW_WIDTH - PADDLE_WIDTH - BALL_SIZE and ballY + BALL_SIZE >= player2Y and ballY <= player2Y + PADDLE_HEIGHT then
            ballX = WINDOW_WIDTH - PADDLE_WIDTH - BALL_SIZE
            ballDX = -ballDX * 1.1 -- Increase speed slightly
            ballDY = ballDY + math.random(-50, 50) -- Add randomness to vertical velocity
        end

        -- Ball reset and scoring if it goes past paddles
        if ballX < 0 then
            player2Score = player2Score + 1
            resetBall()
        elseif ballX > WINDOW_WIDTH then
            player1Score = player1Score + 1
            resetBall()
        end
    end
end

-- Draw function
function love.draw()
    if gameState == 'title' then
        titleDraw()
    elseif gameState == 'play' then
        -- Draw paddles
        love.graphics.rectangle('fill', 10, player1Y, PADDLE_WIDTH, PADDLE_HEIGHT)
        love.graphics.rectangle('fill', WINDOW_WIDTH - 10 - PADDLE_WIDTH, player2Y, PADDLE_WIDTH, PADDLE_HEIGHT)

        -- Draw ball
        love.graphics.rectangle('fill', ballX, ballY, BALL_SIZE, BALL_SIZE)

        -- Draw scores
        drawScores()
    end
end