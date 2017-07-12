class Board
  attr_reader :cells

  def initialize(size=8)
    cell_count = size * size
    @cells = Array.new(cell_count)
    cell_count.times.each do |i|
      @cells[i] = Cell.new(i+1)
    end
    @cells.freeze
    freeze
  end

  def get(position)
    if position >= @cells.count
      final_cell
    else
      @cells[position - 1]
    end
  end

  def final_cell
    @cells.last
  end
end