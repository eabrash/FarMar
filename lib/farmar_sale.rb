require_relative "../far_mar"

class FarMar::Sale

  SALES_FILE = "./support/sales.csv"

  attr_accessor :id, :amount, :purchase_time, :vendor_id, :product_id

  def initialize (line)

    @id = Integer(line[0])
    @amount = Integer(line[1].to_f.round(0))
    @purchase_time = DateTime.parse(line[2])
    @vendor_id = Integer(line[3])
    @product_id = Integer(line[4])

    return self

  end

  def vendor
    return FarMar::Vendor.find(@vendor_id)
  end

  def product
    return FarMar::Product.find(@product_id)
  end

  def self.between(start_time, end_time)

    sales_within_timeframe = []

    CSV.foreach(SALES_FILE) do |line|
      sale_time = DateTime.parse(line[2])
      if  sale_time >= start_time && sale_time <= end_time
        sales_within_timeframe << FarMar::Sale.new(line)
      end
    end

    return sales_within_timeframe

  end

  def self.all

    sales = []

    CSV.foreach(SALES_FILE) do |line|
      sales << FarMar::Sale.new(line)
    end

    return sales

  end

  def self.find(id)

    CSV.foreach(SALES_FILE) do |line|
      if Integer(line[0]) == id
        return FarMar::Sale.new(line)
      end
    end

    return nil  # If sale is not found

  end

  def self.by_vendor(vendor_id)

    vendors_sales = []

    CSV.foreach(SALES_FILE) do |line|
      if Integer(line[3]) == vendor_id
        vendors_sales << FarMar::Sale.new(line)
      end
    end

    return vendors_sales

  end

  def self.by_product(product_id)

    sales_of_product = []

    CSV.foreach(SALES_FILE) do |line|
      if Integer(line[4]) == product_id
        sales_of_product << FarMar::Sale.new(line)
      end
    end

    return sales_of_product

  end

  def source_file
    return SALES_FILE
  end

end

# products_array = FarMar::Sale.all
#
# selected = products_array.select {|product| product.purchase_time > DateTime.parse("2013-11-06 08:45:00 -08:00") && product.purchase_time < DateTime.parse("2013-11-06 09:00:00 -08:00")}
# # earliest = products_array.min_by {|product| product.purchase_time}
#
# selected.each do |sale|
#   puts "ID: #{sale.id}, Time: #{sale.purchase_time}"
# end
#
# puts
# puts selected.length
