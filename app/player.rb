class Player
  attr_reader :name, :position, :prizes

  def initialize(name, board)
    @name = name
    @board = board
    @position = 0
    @prizes = []
  end

  def advance(integer)
    old_position = @position
    new_cell = @board.get(@position + integer)
    new_position = new_cell.integer

    puts "#{name} has advanced #{integer} cells from #{old_position} to #{new_position}"
    if new_cell.has_portal?
      if new_cell.has_ladder?
        new_cell = new_cell.get_ladder.final_cell
        puts "Lucky #{name}! You moved up a ladder from #{new_position} to #{new_cell.integer}"
      else
        new_cell = new_cell.get_snake.final_cell
        puts "Too bad #{name}! You were eaten by a snake from #{new_position} to #{new_cell.integer}"
      end
    end

    if new_cell.has_prize?
      prize = new_cell.get_prize
      @prizes << prize
      puts "Congratulations #{name}! You have won #{prize}"
    end

    if new_cell == @board.final_cell
      throw(:player_won, self)
    end

    @position = new_cell.integer
  end

  def dice_map
    {'Liverpool v Everton' => 6,
     'Man Utd v Man City' => 5,
     'Arsenal v Chelsea' => 4,
     'Aston Villa v WBA' => 3,
     'Leeds v Sheffield Wednesday' => 2,
     'Swansea v Cardiff' => 1}
  end
end