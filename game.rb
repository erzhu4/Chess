require_relative 'piece'
require_relative 'board'

class ChessGame

  def intiailize(white_player, black_player)
    @white_player = white_player
    @black_player = black_player
    @current_player =
    @board = Board.new
  end

  def play
    @board.set_up
  end


end
