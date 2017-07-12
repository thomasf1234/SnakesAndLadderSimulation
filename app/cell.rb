class Cell
  attr_reader :integer, :portal, :prize

  def initialize(integer)
    @integer = integer
  end

  def has_portal?
    !@portal.nil?
  end

  def has_prize?
    !@prize.nil?
  end

  def set_prize(prize)
    @prize = prize
  end

  def get_prize
    @prize
  end

  def set_portal(portal)
    @portal = portal
  end

  def has_snake?
    has_portal? && @portal.kind_of?(Snake)
  end

  def has_ladder?
    has_portal? && @portal.kind_of?(Ladder)
  end

  def get_snake
    has_snake? ? @portal : nil
  end

  def get_ladder
    has_ladder? ? @portal : nil
  end

  def >(cell)
    @integer > cell.integer
  end

  def <(cell)
    cell > self
  end
end