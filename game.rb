require_relative 'piece'
require_relative 'board'
require_relative 'player'

class ChessGame

  def initialize(white_player, black_player)
    @white_player = white_player
    @black_player = black_player
    @current_player = white_player
    @board = Board.new
  end

  def play
    @board.set_up
    @board.display

    until @board.over?
      turn
      @board.display
    end

    if @board.checkmate?(:white)
      puts "Black wins!"
    elsif @board.checkmate?(:black)
      puts "White wins!"
    end
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
    if @current_player == @white_player
      @current_player = @black_player
    else
      @current_player = @white_player
    end
  end

end
