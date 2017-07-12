class Portal
  attr_reader :initial_cell, :final_cell

  def initialize(initial_cell, final_cell)
    if initial_cell.kind_of?(Cell) && final_cell.kind_of?(Cell)
      @initial_cell = initial_cell
      @final_cell = final_cell
      freeze
    else
      raise ArgumentError.new("initial_cell, final_cell must be instance of class Cell")
    end
  end
end