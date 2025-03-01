-- Initialize scores
player1Score = 0
player2Score = 0

-- Function to reset scores
function resetScores()
    player1Score = 0
    player2Score = 0
end

-- Function to draw scores
function drawScores()
    love.graphics.setFont(scoreFont)
    love.graphics.print(player1Score, WINDOW_WIDTH / 2 - 50, 100)
    love.graphics.print(player2Score, WINDOW_WIDTH / 2 + 30, 100)
end