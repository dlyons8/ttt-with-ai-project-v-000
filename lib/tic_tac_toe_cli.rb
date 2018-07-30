class TicTacToeCLI

  def self.welcome
    puts "Welcome to Tic Tac Toe!"
    puts
  end

  def self.start
    puts "To begin, please select 0, 1, or 2 players:"
    number = gets.chomp
    if number == "0"
      Game.new(Players::Computer.new("X"), player_2 = Players::Computer.new("O")).play
    elsif number == "1"
      puts "Do you want to go first as 'X'? Y or N."
      ans = gets.chomp
      if ans.downcase == "yes" || ans.downcase == "y"
        puts "You are Player 1."
        Game.new(Players::Human.new("X"), Players::Computer.new("O")).play
      elsif ans.downcase == "n" || ans.downcase == "no"
        puts "You are Player 2."
        Game.new(Players::Computer.new("X"), Players::Human.new("O")).play
      end
    elsif number == "2"
      puts "Thank you."
      puts
      puts "Player 1, please go first."
      Game.new(Players::Human.new("X"), player_2 = Players::Human.new("O")).play
    elsif number.downcase == "exit" || number.downcase == "quit"
      exit
    else
      start
    end
  end
end
