class HumanPlayer

  COLS = {
    "a" => 0,
    "b" => 1,
    "c" => 2,
    "d" => 3,
    "e" => 4,
    "f" => 5,
    "g" => 6,
    "h" => 7
  }


  attr_reader :color

  def initialize(color)
    @color = color
  end

  def get_move
    print "What is your move? "
    move_arr = gets.chomp.split(",")
    move_arr.map do |str|
      [str[1].to_i - 1, COLS[str[0]]]
    end
  end

end
