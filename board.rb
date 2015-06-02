require 'byebug'
class Board

  SIZE = 8

  def self.valid_pos?(pos)
    pos.all? { |i| i.between?(0, SIZE - 1) }
  end

  def initialize
    @grid = Array.new(SIZE) { Array.new(SIZE) }
  end

  def set_up
    @grid[1].each_index do |col|
      @grid[1][col] = Pawn.new(self, [1, col], :white)
    end

    @grid[SIZE - 2].each_index do |col|
      @grid[SIZE - 2][col] = Pawn.new(self, [SIZE - 2, col], :black)
    end

    [[0, :white], [SIZE - 1, :black]].each do |row, color|
      #debugger
      @grid[row][0] = Rook.new(self, [row, 0], color)
      @grid[row][1] = Knight.new(self, [row, 1], color)
      @grid[row][2] = Bishop.new(self, [row, 2], color)
      @grid[row][3] = Queen.new(self, [row, 3], color)
      @grid[row][4] = King.new(self, [row, 3], color)
      @grid[row][5] = Bishop.new(self, [row, 5], color)
      @grid[row][6] = Knight.new(self, [row, 6], color)
      @grid[row][7] = Rook.new(self, [row, 7], color)
    end

    nil
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, piece)
    row, col = pos
    @grid[row][col] = piece

    piece.pos = pos unless piece.nil?

    piece
  end

  def display
    @grid.each do |row|
      row.each do |square|
        print square ? square.to_s : "▢"
      end
      puts
    end

    nil
  end

  def move(start_pos, final_pos)
    raise NoPieceError unless self[start_pos]

    unless self[start_pos].valid_moves.include?(final_pos)
      raise InvalidMoveError
    end

    self[start_pos], self[final_pos] = nil, self[start_pos]

    nil
  end

  def dup
    new_board = Board.new

    @grid.each_with_index do |row, row_idx|
      row.each_with_index do |square, col_idx|
        next unless square
        color = square.color
        piece_type = square.class
        piece = piece_type.new(new_board, [row_idx, col_idx], color)
        new_board[[row_idx, col_idx]] = piece
      end
    end

    new_board
  end

  

end############################################


class NoPieceError < StandardError
end

class InvalidMoveError < StandardError
end
