require_relative "../far_mar"
require_relative "../lib/farmar_vendor.rb"
require_relative "../lib/farmar_sale.rb"

class FarMar::Product

  PRODUCT_FILE = "./support/products.csv"

  attr_accessor :id, :name, :vendor_id

  # Make a new Product object using a line from the source CSV (as an array).

  def initialize (line)

    @id = Integer(line[0])
    @name = line[1]
    @vendor_id = Integer(line[2])

    return self

  end

  # Return the Vendor that sells this Product.

  def vendor
    return FarMar::Vendor.find(@vendor_id)
  end

  # Return the Sales in which this Product was sold.

  def sales
    return FarMar::Sale.by_product(@id)
  end

  # Return the number of Sales in which this Product was sold.

  def number_of_sales
    return FarMar::Sale.by_product(@id).length
  end

  # Return all the products specified in the source CSV.

  def self.all

    products = []

    CSV.foreach(PRODUCT_FILE) do |line|
      products << FarMar::Product.new(line)
    end

    return products

  end

  # Return the Product instance with the specified ID, or nil if that ID is not
  # found in the source CSV.

  def self.find(id)

    CSV.foreach(PRODUCT_FILE) do |line|
      if Integer(line[0]) == id
        return FarMar::Product.new(line)
      end
    end

    return nil  # If product is not found

  end

  # Return all the Product objects associated with a particular Vendor.

  def self.by_vendor(vendor_id)

    vendors_products = []

    CSV.foreach(PRODUCT_FILE) do |line|
      if Integer(line[2]) == vendor_id
        vendors_products << FarMar::Product.new(line)
      end
    end

    return vendors_products

  end

  # Return the source CSV file path for the Product objects.

  def source_file
    return PRODUCT_FILE
  end

end
