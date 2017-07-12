class Dice
  REGEX_DICE = /[1-6]/

  def initialize(auto=false)
    @auto = auto
  end

  def roll
    @auto ? auto_roll : manual_roll
  end

  private
  def auto_roll
    puts "auto rolling the dice"
    rand(1..6)
  end

  def manual_roll(prompt="Please enter dice roll result: ", is=STDIN, os=STDOUT)
    roll_result = nil
    has_roll_result = false

    until has_roll_result
      os.print prompt
      roll_result = is.gets.chomp

      if !roll_result.match(REGEX_DICE)
        os.puts("roll_result must be between 1 and 6. Retrying")
        next
      else
        has_roll_result = true
        roll_result = roll_result.strip.to_i
      end
    end

    roll_result
  end
end