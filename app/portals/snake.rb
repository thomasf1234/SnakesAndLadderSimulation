class Snake < Portal
  def initialize(initial_cell, final_cell)
    if initial_cell > final_cell
      super
    else
      raise ArgumentError.new("Snakes must have the initial_cell greater than final_cell")
    end
  end
end