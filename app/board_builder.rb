class BoardBuilder
  SABL_EXT = ".salb"
  DEFAULT_SIZE = 8

  def build(source_path="resources/boards/classic.salb")
    if File.extname(source_path) == SABL_EXT
      if File.exists?(source_path)
        board_config = parse_file(source_path)
        # validate_board_config(board_config)
        board = Board.new(board_config[:scale])

        board_config[:ladders].each do |ladder_config|
          initial_cell = board.get(ladder_config.first)
          final_cell = board.get(ladder_config.last)
          initial_cell.set_portal(Ladder.new(initial_cell, final_cell))
        end

        board_config[:snakes].each do |snake_config|
          initial_cell = board.get(snake_config.first)
          final_cell = board.get(snake_config.last)
          initial_cell.set_portal(Snake.new(initial_cell, final_cell))
        end

        board_config[:prizes].each do |prize_config|
          cell = board.get(prize_config.first)
          prize = prize_config.last
          cell.set_prize(prize)
        end

        board
      else
        raise Errno::ENOENT.new(source_path)
      end
    else
      raise ArgumentError.new("source_path must be a #{SABL_EXT}")
    end
  end

  protected
  def parse_file(source_path)
    board_config = {
        scale: DEFAULT_SIZE,
        snakes: [],
        ladders: [],
        prizes: []
    }

    File.foreach(source_path) do |line|
      line = line.strip

      if line.match(/^ *ladder +\d+ +\d+ *$/)
        initial_val, final_val = line.scan(/\d+/).map(&:to_i).sort
        board_config[:ladders] << [initial_val, final_val]

      elsif line.match(/^ *snake +\d+ +\d+ *$/)
        final_val, initial_val = line.scan(/\d+/).map(&:to_i).sort
        board_config[:snakes] << [initial_val, final_val]
      elsif line.match(/^ *scale +\d+ *$/)
        scale_val = line.scan(/\d+/).first.to_i
        board_config[:scale] = scale_val
      elsif line.match(/^ *prize +\d+ +[^ ]+ *$/)
        cell_int, prize = line.match(/\d+ +[^ ]+/).to_s.split(" ").map(&:strip)
        board_config[:prizes] << [cell_int.to_i, prize]
      else
        #ignore
      end
    end

    board_config
  end

  def validate_board_config(board_config)
    scale = board_config[:scale]
    raise "scale must be greater than 1" if scale < 2
    length = scale * scale
    snake_cell_values = board_config[:snakes].flatten.uniq
    ladder_cell_values = board_config[:ladders].flatten.uniq

    snake_cell_max = snake_cell_values.max
    snake_cell_min = snake_cell_values.min
    if snake_cell_max >= length || snake_cell_max <
    snake_cell_values.max
        snake_cell_values.min < 1
      raise "snake value invalid : (#{snake_cell_values.min},#{snake_cell_values.max})"
    end

    if ladder_cell_values.max > length || ladder_cell_values.min < 2
      raise "ladder value invalid : (#{ladder_cell_values.min},#{ladder_cell_values.max})"
    end
  end
end