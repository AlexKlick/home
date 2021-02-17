require 'minitest/autorun'
require 'minitest/pride'
require './lib/building'
require './lib/apartment'
require './lib/renter'

class BuildingTest < Minitest::Test

  def setup
    @building = Building.new
    @unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})
    @unit2 = Apartment.new({number: "B2", monthly_rent: 999, bathrooms: 2, bedrooms: 2})
  end

  def test_it_exists
    assert_instance_of Building, @building
  end

  def test_it_has_attr
    assert_equal [], @building.units
    @building.add_unit(@unit1)
    @building.add_unit(@unit2)
    assert_equal building.units, [@unit1,@unit2]
  end

  def test_can_add_renter
    @building.add_unit(@unit1)
    @building.add_unit(@unit2)
    #require 'pry'; binding.pry
    assert_equal @building.renters, []
    renter1 = Renter.new("Aurora")
    @unit1.add_renter(renter1)
    assert_equal @building.renters, ["Aurora"]
    renter2 = Renter.new("Tim")
    @unit2.add_renter(renter2)

    assert_equal @building.renters, ["Aurora", "Tim"]
  end

  def test_can_average_rent
    renter1 = Renter.new("Aurora")
    @unit1.add_renter(renter1)
    renter2 = Renter.new("Tim")
    @unit1.add_renter(renter2)
    assert_equal building.average_rent, 1099.5
  end


end
