class Piece

  def initialize(board, pos, color)
    @board = board
    @pos = pos
    @color = color
  end

  def move
  end

  private
  def self.valid_pos?(pos)
    pos.all? { |idx| idx.between?(0, 7) }
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
  end

end#####################################################################

class SteppingPiece < Piece
end
