require_relative "../far_mar"
require_relative "../lib/farmar_vendor.rb"
require_relative "../lib/farmar_sale.rb"

class FarMar::Product

  PRODUCT_FILE = "./support/products.csv"

  attr_accessor :id, :name, :vendor_id

  def initialize (line)

    @id = Integer(line[0])
    @name = line[1]
    @vendor_id = Integer(line[2])

    return self

  end

  def vendor
    return FarMar::Vendor.find(@vendor_id)
  end

  def sales
    return FarMar::Sale.by_product(@id)
  end

  def number_of_sales
    return FarMar::Sale.by_product(@id).length
  end

  def self.all

    products = []

    CSV.foreach(PRODUCT_FILE) do |line|
      products << FarMar::Product.new(line)
    end

    return products

  end

  def self.find(id)

    CSV.foreach(PRODUCT_FILE) do |line|
      if Integer(line[0]) == id
        return FarMar::Product.new(line)
      end
    end

    return nil  # If product is not found

  end

  def self.by_vendor(vendor_id)

    vendors_products = []

    CSV.foreach(PRODUCT_FILE) do |line|
      if Integer(line[2]) == vendor_id
        vendors_products << FarMar::Product.new(line)
      end
    end

    return vendors_products

  end

  def source_file
    return PRODUCT_FILE
  end

end
