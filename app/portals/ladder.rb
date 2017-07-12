class Ladder < Portal
  def initialize(initial_cell, final_cell)
    if final_cell > initial_cell
      super
    else
      raise ArgumentError.new("Ladders must have the final_cell greater than initial_cell")
    end
  end
end