require './lib/vendor'
require 'pry'
require 'minitest/autorun'
require 'minitest/pride'

class VendorTest < Minitest::Test
  def setup
    @vendor = Vendor.new("Rocky Mountain Fresh")

    assert_instance_of Vendor, @vendor
  end

  def test_attributes
    assert_equal "Rocky Mountain Fresh", @vendor.name
    expected = {}

    assert_equal "Rocky Mountain Fresh", @vendor.name
    assert_equal expected, @vendor.inventory
  end

  def test_it_keeps_track_of_inventory
    assert_equal 0, @vendor.check_stock("Peaches")
    @vendor.stock("Peaches", 30)
    @vendor.check_stock("Peaches")
    @vendor.stock("Peaches", 25)
    assert_equal 55, @vendor.check_stock("Peaches")
    @vendor.stock("Tomatoes", 12)

    expected =
    {"Peaches"=>55, "Tomatoes"=>12}

    assert_equal expected, @vendor.inventory
  end

  
end
