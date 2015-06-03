#encoding: utf-8
require_relative 'board'
require 'byebug'

class Piece

  attr_reader :color
  attr_accessor :pos

  def initialize(board, color)
    @board = board
    @color = color
    @pos = nil
  end

  def move_into_check?(pos)
    duped_board = @board.dup
    duped_board[pos] = self.class.new(duped_board, @color)
    duped_board[@pos] = nil
    duped_board.in_check?(@color)
  end

  def valid_moves
    moves.delete_if do |move|
      self.move_into_check?(move)
    end
  end

  def dup(duped_board)
    self.class.new(duped_board, @color)
  end
end

class SlidingPiece < Piece

  def initialize(board, color)
    super(board, color)
  end

  def moves
    x, y = @pos
    moves = []

    self.class::DIRS.each do |dx, dy|
      (1...Board::SIZE).each do |magnitude|
        move = [x + dx * magnitude, y + dy * magnitude]

        break unless Board.valid_pos?(move)

        if @board[move]
          moves << move unless @board.occupied_by?(@color, move)
          break
        end

        moves << move
      end
    end

    moves
  end

end#####################################################################

class SteppingPiece < Piece

  def initialize(board, color)
    super(board, color)
  end

  def moves
    x, y = @pos
    moves = []

    self.class::STEPS.each do |dx, dy|
      move = [x + dx, y + dy]

      next unless Board.valid_pos?(move)
      next if @board.occupied_by?(@color, move)

      moves << move
    end

    moves
  end

end#######################################

class Pawn < Piece

  def initialize(board, color)
    super(board, color)
    @dir = (@color == :white) ? [1, 0] : [-1, 0]
    @sides = [[0, 1], [0, -1]]
  end

  def moves
    x, y = @pos

    dx, dy = @dir
    move = [x + dx, y]
    return [] unless Board.valid_pos?(move)

    moves = []
    moves << move unless @board[move]

    @sides.each do |sx, sy|
      other_color = (@color == :white) ? :black : :white
      move = [x + dx + sx, y + dy + sy]
      if @board.occupied_by?(other_color, move)
        moves << move
      end
    end

    if first_move?
      double_move = [x + (dx * 2), y]
      unless @board[double_move]
        moves << double_move
      end
    end

    moves
  end

  def first_move?
    x, y = @pos
    (@color == :white && x == 1) ||
      (@color == :black && x == Board::SIZE - 2)
  end

  def to_s
    case @color
    when :white
      "♙"
    when :black
      "♟"
    end
  end
end#####################################################################

class Rook < SlidingPiece

  DIRS = [
    [1, 0],
    [-1, 0],
    [0, 1],
    [0, -1],
  ]

  def initialize(board, color)
    super(board, color)
  end

  def to_s
    case @color
    when :white
      "♖"
    when :black
      "♜"
    end
  end

end

class Bishop < SlidingPiece

  DIRS = [
    [1, 1],
    [-1, 1],
    [1, -1],
    [-1, -1]
  ]

  def initialize(board, color)
    super(board, color)
  end

  def to_s
    case @color
    when :white
      "♗"
    when :black
      "♝"
    end
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

  def initialize(board, color)
    super(board, color)
  end

  def to_s
    case @color
    when :white
      "♕"
    when :black
      "♛"
    end
  end

end

class Knight < SteppingPiece

  STEPS = [
    [1, 2],
    [1, -2],
    [-1, 2],
    [-1, -2],
    [2, 1],
    [2, -1],
    [-2, 1],
    [-2, -1]
  ]

  def initialize(board, color)
    super(board, color)
  end

  def to_s
    case @color
    when :white
      "♘"
    when :black
      "♞"
    end
  end

end

class King < SteppingPiece

  STEPS = [
    [1, 1],
    [1, 0],
    [1, -1],
    [0, -1],
    [-1, -1],
    [-1, 0],
    [-1, 1],
    [0, 1]
  ]

  def initialize(board, color)
    super(board, color)
  end

  def to_s
    case @color
    when :white
      "♔"
    when :black
      "♚"
    end
  end
end
