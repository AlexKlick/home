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
    assert_equal @building.units, [@unit1,@unit2]
  end

  def test_can_add_renter
    @building.add_unit(@unit1)
    @building.add_unit(@unit2)
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
    @building.add_unit(@unit1)
    @building.add_unit(@unit2)
    assert_equal @building.average_rent, 1099.5
  end

  def test_full_test
    building = Building.new
    unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})
    unit2 = Apartment.new({number: "B2", monthly_rent: 999, bathrooms: 1, bedrooms: 2})
    unit3 = Apartment.new({number: "C3", monthly_rent: 1150, bathrooms: 2, bedrooms: 2})
    unit4 = Apartment.new({number: "D4", monthly_rent: 1500, bathrooms: 2, bedrooms: 3})
    renter1 = Renter.new("Spencer")
    building.add_unit(unit1)
    building.add_unit(unit2)
    building.add_unit(unit3)
    assert_equal building.rented_units, []
    unit2.add_renter(renter1)
    assert_equal building.rented_units, [unit2]
    assert_equal renter1, building.renter_with_highest_rent
    renter2 = Renter.new("Jessie")
    unit1.add_renter(renter2)
    assert_equal renter2, building.renter_with_highest_rent
    renter3 = Renter.new("Max")
    unit3.add_renter(renter3)
    assert_equal renter2, building.renter_with_highest_rent
    building.add_unit(unit4)
    require 'pry'; binding.pry
    assert_equal building.units_by_number_of_bedrooms, {3 => ["D4" ],
2 => ["B2", "C3"],
1 => ["A1"]}
  end
end
