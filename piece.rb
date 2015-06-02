class Piece

  attr_reader :color

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

class Pawn < Piece

  def initialize(board, pos, color)
    super(board, pos, color)
    @dir = (@color == :white) ? [1, 0] : [-1, 0]
    @sides = [[0, 1], [0, -1]]
  end

  def valid_moves
    x, y = @pos

    dx, dy = @dir
    move = [x + dx, y + dy]
    return [] unless Board.valid_pos?(move)

    moves = []
    moves << move unless @board[move]

    @sides.each do |sx, sy|
      side_move = [x + dx + sx, y + dy + sy]
      if @board[side_move] && @board[side_move].color != @color
        moves << side_move
      end
    end


    moves
  end
end#####################################################################

class Rook < SlidingPiece

  DIRS = [
    [1, 0],
    [-1, 0],
    [0, 1],
    [0, -1],
  ]

  def initialize(board, pos, color)
    super(board, pos, color, DIRS)
  end

end

class Bishop < SlidingPiece

  DIRS = [
    [1, 1],
    [-1, 1],
    [1, -1],
    [-1, -1]
  ]

  def initialize(board, pos, color)
    super(board, pos, color, DIRS)
  end

end

class Queen < SlidingPiece

  DIRS = [
    [1, 1],
    [-1, 1],
    [1, -1],
    [-1, -1],
    [1, 0],
    [-1, 0],
    [0, 1],
    [0, -1]
  ]

  def initialize(board, pos, color)
    super(board, pos, color, DIRS)
  end

end
