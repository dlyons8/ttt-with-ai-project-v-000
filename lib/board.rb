class Board
  attr_accessor :cells

  def reset!
    # can reset the state of the cells in the board
    # sets the cells of the board to a 9 element array of " "
    @cells = Array.new(9, " ")
  end
  def initialize
    # sets the cells of the board to a 9 element array of " "
    self.reset!
  end
  def display
    # prints the board
    puts " #{cells[0]} | #{cells[1]} | #{cells[2]} "
    puts "-----------"
    puts " #{cells[3]} | #{cells[4]} | #{cells[5]} "
    puts "-----------"
    puts " #{cells[6]} | #{cells[7]} | #{cells[8]} "
  end
  def position(index)
    # takes in user input and returns the value of the board cell
    idx = input_to_index(index)
    cells[idx]
  end
  def full?
    # returns true for a full board
    # returns false for an in-progress game
    cells.all? {|token| token == "X" || token == "O"}
  end
  def turn_count
    # returns the amount of turns based on cell value
    cells.count { |cell| cell == "X" || cell == "O" }
  end
  def taken?(index)
    # returns true if the position is X or O
    # returns false if the position is empty or blank
    idx = input_to_index(index)
    cells[idx] == "O" || cells[idx] == "X"
  end
  def valid_move?(index)
    # returns true for user input between 1-9 that is not taken
    idx = input_to_index(index)
    idx.between?(0,8) && cells[idx] != "O" && cells[idx] != "X"
  end
  def update(index, player)
    # updates the cells in the board with the player token according to the input
    idx = input_to_index(index)
    cells[idx] = player.token
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end
end
