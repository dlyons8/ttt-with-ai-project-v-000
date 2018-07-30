class Game
  attr_accessor :player_1, :player_2, :board
  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
  ]

  TRAPS = [
    [0,4,2],
    [0,4,8],
    [2,4,8],
    [4,6,8],
  ]

  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    # accepts 2 players and a board
    # defaults to two human players, X and O, with an empty board
    @player_1 = player_1
    @player_2 = player_2
    @board = board
  end

  def cells
    @board.cells
  end

  def turn_count
    cells.count { |cell| cell == "X" || cell == "O" }
  end

  def current_player
    # returns the correct player, X, for the third move
    turn_count.even? ? player_1 : player_2
  end

  def won?
    # returns false for a draw
    # returns the correct winning combination in the case of a win
    WIN_COMBINATIONS.detect do |combo|
      @board.cells[combo[0]] == @board.cells[combo[1]] &&
      @board.cells[combo[0]] == @board.cells[combo[2]] &&
      @board.taken?(combo[0] + 1)
    end
  end

  def full?
    cells.all? {|token| token == "X" || token == "O"}
  end

  def draw?
    # returns true for a draw
    # returns false for a won game
    # returns false for an in-progress game
    full? && !(won?)
  end

  def over?
    # returns true for a draw
    # returns true for a won game
    # returns false for an in-progress game
    draw? || won? || full?
  end
  def winner
    # returns X when X won
    # returns O when O won
    # returns nil when no winner
    won? ? won?.first : nil
  end
  def turn
    # makes valid moves
    # asks for input again after a failed validation
    # changes to player 2 after the first turn
    player = current_player
    input = player.move(@board)
    if @board.valid_move?(input)
      @board.update(input, player)
      @board.display
    elsif input == "exit"
      quit
    elsif input == "instructions"
      instructions
    else
      turn
    end
  end

  def play
    instructions
    puts "New Game:"
    puts
    @board.display
    puts
    until over?
      if turn_count.even?
        player_number = "1"
      else
        player_number = "2"
      end
      puts "Player #{player_number}'s turn"
      puts
      turn
      puts
    end
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
    end_game
  end

  def end_game
    puts
    puts "Would you like to play again? Y or N?"
    reply = gets.chomp
    if reply.upcase == "Y"
      config
    else
      puts
      puts "Thank you for playing Tic Tac Toe!"
      exit
    end
  end

  def instructions
    puts
    puts "To play, please enter a number between 1-9 when prompted to place your token in the cells in the area numbered on the board below:"
    puts
    puts " 1 | 2 | 3 "
    puts "-----------"
    puts " 4 | 5 | 6 "
    puts "-----------"
    puts " 7 | 8 | 9 "
    puts
    puts "To ask for instructions anytime, type 'instructions,' or to exit, type 'exit.'"
    puts
  end

  def quit
    puts
    puts "Are you sure you want to end game? Y or N."
    ans = gets.chomp
    if ans.downcase == "yes" || ans.downcase == "y"
      puts "You lose."
      end_game
    elsif ans.downcase == "n" || ans.downcase == "no"
    else
      quit
    end
  end

  def config
  puts "Do you need a new configuration? Y or N"
  ans = gets.chomp
    if ans.upcase == "Y"
      TicTacToeCLI.start
    elsif ans.upcase == "N"
      @board.reset!
      play
    else
      config
    end
  end
end
