require 'csv'

class Game
  def initialize(players, board, dice)
    @players = players
    @board = board
    @dice = dice
  end

  def start
    turn = 0
    @players.cycle do |player|
      turn += 1
      puts "Player #{player.name}. Turn #{turn}: Cell #{player.position} Prizes: [#{player.prizes.join(", ")}]"
      roll_result = @dice.roll
      puts "#{player.name} rolled a #{roll_result}"
      player.advance(roll_result)
      puts ""
    end
  end

  def replay(file_path)
    turn = 0
    player = @players.first
    CSV.foreach(file_path, :headers => true) do |row|
      turn += 1
      puts "Player #{player.name}. Turn #{turn}: Cell #{player.position} Prizes: [#{player.prizes.join(", ")}]"
      roll_result = player.dice_map[row['match']]
      puts "#{player.name} rolled a #{roll_result}"
      player.advance(roll_result)
      puts ""
    end
  end
end