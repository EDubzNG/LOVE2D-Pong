-- Title screen variables
local titleText = "Pong"
local instructionText = "Press Enter to Start"

-- Load function for title screen
function titleLoad()
    -- Set the font size for the title and instructions
    titleFont = love.graphics.newFont(48)
    instructionFont = love.graphics.newFont(24)
end

-- Update function for title screen
function titleUpdate(dt)
    -- Check if the Enter key is pressed to start the game
    if love.keyboard.isDown('return') then
        gameState = 'play'
    end
end

-- Draw function for title screen
function titleDraw()
    -- Set the font and draw the title text
    love.graphics.setFont(titleFont)
    love.graphics.printf(titleText, 0, WINDOW_HEIGHT / 2 - 100, WINDOW_WIDTH, 'center')

    -- Set the font and draw the instruction text
    love.graphics.setFont(instructionFont)
    love.graphics.printf(instructionText, 0, WINDOW_HEIGHT / 2, WINDOW_WIDTH, 'center')
end