require_relative 'piece'
require_relative 'board'

class ChessGame

  def intiailize(white_player, black_player)
    @white_player = white_player
    @black_player = black_player
    @current_player = white_player
    @board = Board.new
  end

  def play
    @board.set_up

    until @board.over?
      turn
    end
    #win condition goes here
  end

  def turn
    begin
      move = @current_player.get_move
      @board.move(*move)
    rescue StandardError => e
      puts e.message
      retry
    end
    toggle_player
  end

  def toggle_player
    @current_player = (@current_player == @white_player) ?
                      @black_player : @white_player
  end

end
