require './classes'

game = Board.new(20,20)
board = game.grid
board[5][5].born
board[6][5].born
board[7][5].born
board[7][4].born
board[6][3].born
game.print_grid

def play_rounds(game,rounds)
    rounds.times do
        puts `clear`
        game.step_forward
        game.print_grid
        sleep(0.2)
    end
end

play_rounds(game,30)