class Building
  attr_reader :units, :renters
  def initialize
    @units = []
    @renters = []
  end

  def add_unit(unit)
    @units << unit
  end
  def renters
    @renters = @units.map {|unit| unit.renter}.compact
    @renters.map {|renter| renter.name}
  end
  def average_rent
    @units.map {|unit| unit.monthly_rent}.sum(0.0) / @units.size
  end
end