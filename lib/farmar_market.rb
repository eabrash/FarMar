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
