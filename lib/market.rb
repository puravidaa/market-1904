class Market
  attr_reader :name, :vendors
  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    vendors_sell = []

    @vendors.map do |vendor|
      if vendor.inventory.keys.include? item
        vendors_sell << vendor
      end
    end
    vendors_sell
  end

  def sorted_item_list

    @vendors.map do |vendor|
      vendor.inventory.keys
    end.sort_by do |item|
      item
    end.flatten.uniq
  end

  def total_inventory
    total_inv = Hash.new(0)
    arr = []

    @vendors.map do |vendor|
      vendor.inventory.each do |name, quantity|
        arr << name
        if arr.include? name
          total_inv[name] += quantity
        else
          total_inv[name] = quantity
        end
      end
    end
    total_inv
  end

  # => if zero, move to next vendor and bring that vendor's quantity to 0
  # => reduce vendor's inventory of that item
  # => ***how do I move to next vendor?***

  def sell(item, quantity)
    @vendors.map do |vendor|
      if vendor.inventory.keys.include? item && vendor.inventory[item] > quantity
        if vendor.inventory[item] <= quantity
          vendor.inventory[item] = 0
        else
          vendor.inventory[item] -= quantity
        end
      end
    end
  end
end
