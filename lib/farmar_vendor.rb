require_relative "../far_mar"
require_relative "../lib/farmar_market.rb"
require_relative "../lib/farmar_product.rb"
require_relative "../lib/farmar_sale.rb"

class FarMar::Vendor

  VENDOR_FILE = "./support/vendors.csv"

  attr_reader :id, :name, :num_employees, :market_id

  def initialize (line)

    @id = Integer(line[0])
    @name = line[1]
    @num_employees = Integer(line[2])
    @market_id = Integer(line[3])

    return self

  end

  # Return the Market that is associated with this Vendor

  def market
    return FarMar::Market.find(@market_id)
  end

  def products
    return FarMar::Product.by_vendor(@id)
  end

  def sales
    return FarMar::Sale.by_vendor(@id)
  end

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

  def self.all

    vendors = []

    CSV.foreach(VENDOR_FILE) do |line|
      vendors << FarMar::Vendor.new(line)
    end

    return vendors

  end

  def self.find(id)

    CSV.foreach(VENDOR_FILE) do |line|
      if Integer(line[0]) == id
        return FarMar::Vendor.new(line)
      end
    end

    return nil  # If sale is not found

  end

  def self.by_market(market_id)

    vendors_of_market = []

    CSV.foreach(VENDOR_FILE) do |line|
      if Integer(line[3]) == market_id
        vendors_of_market << FarMar::Vendor.new(line)
      end
    end

    return vendors_of_market

  end

  def source_file
    return VENDOR_FILE
  end

end
