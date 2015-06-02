class Piece

  def initialize(board, pos, color)
    @board = board
    @pos = pos
    @color = color
  end

  def move
  end
end

class SlidingPiece < Piece

  def initialize(board, pos, color, dirs)
    super(board, pos, color)
    @dirs = dirs
  end

  def valid_moves
    x, y = @pos
    moves = []

    @dirs.each do |dx, dy|
      (1...8). do |magnitude|
        move = [x + dx * magnitude, y + dy * magnitude]

        break unless Board.valid_pos(move)

        if @board[move]
          moves << move unless @board[move].color == @color
          break
        end

        moves << move
      end
    end

    moves
  end

end#####################################################################

class SteppingPiece < Piece

  def initiailize(board, pos, color, steps)
    super(board, pos, color)
    @steps = steps
  end

  def valid_moves
    x, y = @pos
    moves = []

    @steps.each do |dx, dy|
      move = [x + dx, y + dy]

      next unless Board.valid_pos?(move)
      next if @board[move] && @board[move].color == @color

      moves << move
    end

    moves
  end

end#######################################
