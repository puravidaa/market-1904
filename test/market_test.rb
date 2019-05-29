require './lib/market'
require './lib/vendor'
require 'pry'
require 'minitest/autorun'
require 'minitest/pride'

class MarketTest < Minitest::Test
  def setup
    @market = Market.new("South Pearl Street Farmers Market")

    assert_instance_of Market, @market
  end

  def test_attributes
    assert_equal "South Pearl Street Farmers Market", @market.name
    assert_equal [], @market.vendors
  end

  def test_it_adds_vendors
    vendor_1 = Vendor.new("Rocky Mountain Fresh")
#=> #<Vendor:0x00007fe1348a1160...>
    vendor_1.stock("Peaches", 35)
    vendor_1.stock("Tomatoes", 7)
    vendor_2 = Vendor.new("Ba-Nom-a-Nom")
#=> #<Vendor:0x00007fe1349bed40...>
    vendor_2.stock("Banana Nice Cream", 50)
    vendor_2.stock("Peach-Raspberry Nice Cream", 25)
    vendor_3 = Vendor.new("Palisade Peach Shack")
#=> #<Vendor:0x00007fe134910650...>
    vendor_3.stock("Peaches", 65)
    @market.add_vendor(vendor_1)
    @market.add_vendor(vendor_2)
    @market.add_vendor(vendor_3)
    assert_equal [vendor_1, vendor_2, vendor_3], @market.vendors
  end

  def test_it_gets_vendor_names
    vendor_1 = Vendor.new("Rocky Mountain Fresh")
#=> #<Vendor:0x00007fe1348a1160...>
    vendor_1.stock("Peaches", 35)
    vendor_1.stock("Tomatoes", 7)
    vendor_2 = Vendor.new("Ba-Nom-a-Nom")
#=> #<Vendor:0x00007fe1349bed40...>
    vendor_2.stock("Banana Nice Cream", 50)
    vendor_2.stock("Peach-Raspberry Nice Cream", 25)
    vendor_3 = Vendor.new("Palisade Peach Shack")
#=> #<Vendor:0x00007fe134910650...>
    vendor_3.stock("Peaches", 65)
    @market.add_vendor(vendor_1)
    @market.add_vendor(vendor_2)
    @market.add_vendor(vendor_3)
    assert_equal [vendor_1.name, vendor_2.name, vendor_3.name], @market.vendor_names
#=> ["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"]
  end

  def test_it_gets_vendors_that_sell
    # skip
    vendor_1 = Vendor.new("Rocky Mountain Fresh")
#=> #<Vendor:0x00007fe1348a1160...>
    vendor_1.stock("Peaches", 35)
    vendor_1.stock("Tomatoes", 7)
    vendor_2 = Vendor.new("Ba-Nom-a-Nom")
#=> #<Vendor:0x00007fe1349bed40...>
    vendor_2.stock("Banana Nice Cream", 50)
    vendor_2.stock("Peach-Raspberry Nice Cream", 25)
    vendor_3 = Vendor.new("Palisade Peach Shack")
#=> #<Vendor:0x00007fe134910650...>
    vendor_3.stock("Peaches", 65)
    @market.add_vendor(vendor_1)
    @market.add_vendor(vendor_2)
    @market.add_vendor(vendor_3)
    assert_equal [vendor_1, vendor_3], @market.vendors_that_sell("Peaches")
    #=> [#<Vendor:0x00007fe1348a1160...>, #<Vendor:0x00007fe134910650...>]

    assert_equal [vendor_2], @market.vendors_that_sell("Banana Nice Cream")
    #=> [#<Vendor:0x00007fe1349bed40...>]
  end

  def test_it_sorts_vendor_items
    vendor_1 = Vendor.new("Rocky Mountain Fresh")
#=> #<Vendor:0x00007fe1348a1160...>
    vendor_1.stock("Peaches", 35)
    vendor_1.stock("Tomatoes", 7)
    vendor_2 = Vendor.new("Ba-Nom-a-Nom")
#=> #<Vendor:0x00007fe1349bed40...>
    vendor_2.stock("Banana Nice Cream", 50)
    vendor_2.stock("Peach-Raspberry Nice Cream", 25)
    vendor_3 = Vendor.new("Palisade Peach Shack")
#=> #<Vendor:0x00007fe134910650...>
    vendor_3.stock("Peaches", 65)
    @market.add_vendor(vendor_1)
    @market.add_vendor(vendor_2)
    @market.add_vendor(vendor_3)

    expected =
    ["Banana Nice Cream", "Peach-Raspberry Nice Cream", "Peaches", "Tomatoes"]

    assert_equal expected, @market.sorted_item_list

  end

  def test_total_inventory
    vendor_1 = Vendor.new("Rocky Mountain Fresh")
#=> #<Vendor:0x00007fe1348a1160...>
    vendor_1.stock("Peaches", 35)
    vendor_1.stock("Tomatoes", 7)
    vendor_2 = Vendor.new("Ba-Nom-a-Nom")
#=> #<Vendor:0x00007fe1349bed40...>
    vendor_2.stock("Banana Nice Cream", 50)
    vendor_2.stock("Peach-Raspberry Nice Cream", 25)
    vendor_3 = Vendor.new("Palisade Peach Shack")
#=> #<Vendor:0x00007fe134910650...>
    vendor_3.stock("Peaches", 65)
    @market.add_vendor(vendor_1)
    @market.add_vendor(vendor_2)
    @market.add_vendor(vendor_3)

    expected =
    {"Peaches"=>100, "Tomatoes"=>7, "Banana Nice Cream"=>50, "Peach-Raspberry Nice Cream"=>25}

    assert_equal expected, @market.total_inventory
  end

  def test_it_sells_items
    vendor_1 = Vendor.new("Rocky Mountain Fresh")
#=> #<Vendor:0x00007fe1348a1160...>
    vendor_1.stock("Peaches", 35)
    vendor_1.stock("Tomatoes", 7)
    vendor_2 = Vendor.new("Ba-Nom-a-Nom")
#=> #<Vendor:0x00007fe1349bed40...>
    vendor_2.stock("Banana Nice Cream", 50)
    vendor_2.stock("Peach-Raspberry Nice Cream", 25)
    vendor_3 = Vendor.new("Palisade Peach Shack")
#=> #<Vendor:0x00007fe134910650...>
    vendor_3.stock("Peaches", 65)
    @market.add_vendor(vendor_1)
    @market.add_vendor(vendor_2)
    @market.add_vendor(vendor_3)

   @market.sell("Peaches", 200)
    #=> false
   @market.sell("Onions", 1)
    #=> false
   @market.sell("Banana Nice Cream", 5)
    #=> true
   assert_equal 45, vendor_2.check_stock("Banana Nice Cream")
    #=> 45
   @market.sell("Peaches", 40)
    #=> true
   assert_equal 0, vendor_1.check_stock("Peaches")
    #=> 0
   assert_equal 60, vendor_3.check_stock("Peaches")
   #=> 60
  end
end
