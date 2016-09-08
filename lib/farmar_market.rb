require_relative "../far_mar"
require_relative "../lib/farmar_vendor.rb"

class FarMar::Market

  MARKET_FILE = "./support/markets.csv"  # Source file

  attr_reader :id, :name, :address, :city, :county, :state, :zip

  def initialize (line)

    @id = Integer(line[0])
    @name = line[1]
    @address = line[2]
    @city = line[3]
    @county = line[4]
    @state = line[5]
    @zip = line[6]

    return self

  end

  def self.all

    markets = []

    CSV.foreach(MARKET_FILE) do |line|
      markets << FarMar::Market.new(line)
    end

    return markets

  end

  def self.find(id)

    CSV.foreach(MARKET_FILE) do |line|
      if Integer(line[0]) == id
        return FarMar::Market.new(line)
      end
    end

    return nil  # If market is not found

  end

  def vendors
    return FarMar::Vendor.by_market(@id)
  end

  def prefered_vendor(date = false)

    market_vendors = self.vendors
    max_sale = [0, nil] # Initialize array to hold amount at [0] and Vendor object at [1] for highest sales total

    market_vendors.each do |vendor|

      vendor_revenue = vendor.revenue(date)

      if vendor_revenue > max_sale[0]
        max_sale = [vendor_revenue, vendor]
      end

    end

    return max_sale[1]

  end

  def worst_vendor(date = false)

    market_vendors = self.vendors
    min_sale = [Float::INFINITY, nil] # Initialize array to hold amount at [0] and Vendor object at [1] for lowest sales total

    market_vendors.each do |vendor|

      vendor_revenue = vendor.revenue(date)

      if vendor_revenue != 0 && vendor_revenue < min_sale[0]
        min_sale = [vendor_revenue, vendor]
      end

    end

    return min_sale[1]

  end

  def self.search(word)

    word.downcase!
    results = []

    CSV.foreach(MARKET_FILE) do |line|
      if line[1].downcase.include?(word)
        results << FarMar::Market.new(line)
      end
    end

    return results

  end

  def products

    market_vendors = self.vendors

    products = []

    for vendor in market_vendors
      products.concat(vendor.products)
    end

    return products

  end

  def source_file
    return MARKET_FILE
  end

end
