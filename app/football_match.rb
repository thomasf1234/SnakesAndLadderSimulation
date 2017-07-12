class FootballMatch
  attr_reader :home, :away

  def initialize(home, away)
    @home = home.strip
    @away = away.strip
  end

  def to_s
    "#{@home} v #{@away}"
  end
end