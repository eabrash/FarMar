require_relative "../far_mar"
require_relative "../lib/farmar_market.rb"
require_relative "../lib/farmar_product.rb"
require_relative "../lib/farmar_sale.rb"

class FarMar::Vendor

  VENDOR_FILE = "./support/vendors.csv"

  attr_reader :id, :name, :num_employees, :market_id

  # Make a new Vendor object using a line from the CSV file (as an array).

  def initialize (line)

    @id = Integer(line[0])
    @name = line[1]
    @num_employees = Integer(line[2])
    @market_id = Integer(line[3])

    return self

  end

  # Return the Market that this Vendor belongs to.

  def market
    return FarMar::Market.find(@market_id)
  end

  # Get the Products that this Vendor sells.

  def products
    return FarMar::Product.by_vendor(@id)
  end

  # Get the Sales that this Vendor has made.

  def sales
    return FarMar::Sale.by_vendor(@id)
  end

  # Get the revenue of this Vendor (overall if with no argument, or for a date
  # if with a DateTime argument).
  #
  # ======> COULD STAND TO BE IMPROVED (ERROR/WRONG ARGUMENT CATCHING)

  def revenue(date = false)

    my_sales = self.sales

    total = 0

    for sale in my_sales
      if !date
        total += sale.amount
      else
        if sale.purchase_time.to_date == date.to_date
          total += sale.amount
        end
      end
    end

    return total

  end

  # Return all Vendor objects specified in the source CSV file.

  def self.all

    vendors = []

    CSV.foreach(VENDOR_FILE) do |line|
      vendors << FarMar::Vendor.new(line)
    end

    return vendors

  end

  # Return the Vendor object with the specified ID, or nil if the ID is not
  # present in the source CSV file.

  def self.find(id)

    CSV.foreach(VENDOR_FILE) do |line|
      if Integer(line[0]) == id
        return FarMar::Vendor.new(line)
      end
    end

    return nil  # If sale is not found

  end

  # Return all the Vendor objects that belong to a specific Market (whose ID is
  # passed in as an argument). Returns an empty array if there are no vendors
  # corresponding to the market_id argument.

  def self.by_market(market_id)

    vendors_of_market = []

    CSV.foreach(VENDOR_FILE) do |line|
      if Integer(line[3]) == market_id
        vendors_of_market << FarMar::Vendor.new(line)
      end
    end

    return vendors_of_market

  end

  # Returns the source file path for the vendor data.

  def source_file
    return VENDOR_FILE
  end

end
