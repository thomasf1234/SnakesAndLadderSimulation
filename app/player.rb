class Player
  attr_reader :name, :position, :prizes, :dice_map

  def initialize(name, board, dice_map={})
    @name = name
    @board = board
    @position = 0
    @dice_map = dice_map
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
end