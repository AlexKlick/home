class Building
  attr_reader :units, :renters, :rented_units
  def initialize
    @units = []
    @renters = []
    @rented_units = []
  end

  def add_unit(unit)
    @units << unit
  end
  def renters
    @renters = @units.map {|unit| unit.renter}.compact
    @renters.map {|renter| renter.name}
  end
  def average_rent
    @units.map {|unit| unit.monthly_rent}.sum(0.0) / @units.length
  end

  def rented_units
    @units.map {|unit| unit.renter ? unit : nil}.compact
  end

  def renter_with_highest_rent
    highest_rent = 0
    renter = rented_units.map {|unit| unit.monthly_rent > highest_rent ? unit.renter : nil}.compact
    renter[0]
  end

  def units_by_number_of_bedrooms
    bedrooms = Hash.new([])
    @units.map { 
      |unit| 
      if bedrooms[unit.bedrooms].length > 0
        bedrooms[unit.bedrooms]  << unit.number 
      else
        bedrooms[unit.bedrooms] = [unit.number]
      end
    }
    bedrooms
  end
end