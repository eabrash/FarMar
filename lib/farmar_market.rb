require_relative "../far_mar"
require_relative "../lib/farmar_vendor.rb"

class FarMar::Market

  MARKET_FILE = "./support/markets.csv"  # Source file

  attr_reader :id, :name, :address, :city, :county, :state, :zip

  # Make a new Market object using a line from the CSV (as an array).

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

  # Return all market objects created from source CSV file.

  def self.all

    markets = []

    CSV.foreach(MARKET_FILE) do |line|
      markets << FarMar::Market.new(line)
    end

    return markets

  end

  # Return a specific market object with the given ID (or nil if the specified id
  # is not in the CSV file).

  def self.find(id)

    CSV.foreach(MARKET_FILE) do |line|
      if Integer(line[0]) == id
        return FarMar::Market.new(line)
      end
    end

    return nil  # If market is not found

  end

  # Return all the vendors associated with a particular Market object.

  def vendors
    return FarMar::Vendor.by_market(@id)
  end

  # Return the vendor with the highest sales (overall or for a given date).
  #
  # In the event of multiple vendors tied for highest revenue, the first of the tied
  # vendors will be returned.
  #
  # If there are no vendors with sales assciated with the date, returns nil.
  #
  # ======> COULD STAND TO BE IMPROVED (TIE CASE)


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

  # Returns the vendor with the lowest sales total (overall or for a given date).
  #
  # Note on implementation: this currently returns the vendor with the lowest
  # non-zero sales total. Otherwise, when the date-specific version is used, there
  # will generally be a bunch of zero-selling vendors who are tied for worst - presumably
  # because they weren't there that day and thus have zero sales. This doesn't seem
  # that meaningful to me (ideally we would want both attendance data and sales
  # data separately), and it seemed more useful to simply compare the vendors who were
  # clearly present - i.e., have a sale - and return the worst out of them. However,
  # this is something I would clarify with the client in a real-world project.
  #
  # In the event of multiple vendors tied for lowest revenue, the first of the tied
  # vendors will be returned.
  #
  # If there are no vendors with sales assciated with the date, returns nil.
  #
  # ======> COULD STAND TO BE IMPROVED (TIE CASE + PROBLEM INTERPRETATION)

  def worst_vendor(date = false)

    market_vendors = self.vendors
    min_sale = [Float::INFINITY, nil] # Initialize array to hold amount at [0] and Vendor object at [1] for lowest sales total

    market_vendors.each do |vendor|

      vendor_revenue = vendor.revenue(date)

      if vendor_revenue != 0 && vendor_revenue < min_sale[0]  # If vendor had any sales that day AND their revenue is less than the existing minimum
        min_sale = [vendor_revenue, vendor]
      end

    end

    return min_sale[1]

  end

  # Find markets whose name includes a search term.

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

  # Returns the products associated with a market (via the vendors who sell
  # them, who are uniquely associated with the market).

  def products

    market_vendors = self.vendors

    products = []

    for vendor in market_vendors
      products.concat(vendor.products)
    end

    return products

  end

  # Returns source CSV file path.

  def source_file
    return MARKET_FILE
  end

end
