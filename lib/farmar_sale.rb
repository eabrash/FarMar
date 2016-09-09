require_relative "../far_mar"

class FarMar::Sale

  SALES_FILE = "./support/sales.csv"

  attr_accessor :id, :amount, :purchase_time, :vendor_id, :product_id

  # Make a new Sale object using a line from the source CSV file (as an array).

  def initialize (line)

    @id = Integer(line[0])
    @amount = Integer(line[1].to_f.round(0))
    @purchase_time = DateTime.parse(line[2])
    @vendor_id = Integer(line[3])
    @product_id = Integer(line[4])

    return self

  end

  # Return the Vendor who made this Sale.

  def vendor
    return FarMar::Vendor.find(@vendor_id)
  end

  # Return the Product that was sold in this Sale.

  def product
    return FarMar::Product.find(@product_id)
  end

  # Return all the Sales that took place between start_time and end_time.
  # ======> COULD STAND TO BE IMPROVED (BETTER HANDLING OF WRONG INPUT CASES)

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

  # Return all the Sale objects specified by the source CSV.

  def self.all

    sales = []

    CSV.foreach(SALES_FILE) do |line|
      sales << FarMar::Sale.new(line)
    end

    return sales

  end

  # Return the Sale object with the given ID (or nil if that ID is not present
  # in the source CSV file).

  def self.find(id)

    CSV.foreach(SALES_FILE) do |line|
      if Integer(line[0]) == id
        return FarMar::Sale.new(line)
      end
    end

    return nil  # If sale is not found

  end

  # Return the Sale objects (from the CSV file) that are associate with a
  # particular Vendor. I.e., return the full list of a vendor's sales.

  def self.by_vendor(vendor_id)

    vendors_sales = []

    CSV.foreach(SALES_FILE) do |line|
      if Integer(line[3]) == vendor_id
        vendors_sales << FarMar::Sale.new(line)
      end
    end

    return vendors_sales

  end

  # Return all the Sales in which a given Product was sold.

  def self.by_product(product_id)

    sales_of_product = []

    CSV.foreach(SALES_FILE) do |line|
      if Integer(line[4]) == product_id
        sales_of_product << FarMar::Sale.new(line)
      end
    end

    return sales_of_product

  end

  # Source CSV file path for sales.

  def source_file
    return SALES_FILE
  end

end

sales = FarMar::Sale.all

per_vendor_cents_total = []

sales.each do |sale|

  if per_vendor_cents_total.keys.include?(sale.vendor_id)
    per_vendor_cents_total[sale.vendor_id] += sale.amount
  else
    per_vendor_cents_total[sale.vendor_id] = sale.amount
  end

end

highest_scorers = []

5.times do
  highest = per_vendor_cents_total.max_by {|vendor_id, sales_made| sales_made}
  per_vendor_cents_total.delete(highest[0])
  highest_scorers << highest
end

print highest_scorers


# selected = products_array.select {|product| product.purchase_time > DateTime.parse("2013-11-06 08:45:00 -08:00") && product.purchase_time < DateTime.parse("2013-11-06 09:00:00 -08:00")}
# # earliest = products_array.min_by {|product| product.purchase_time}
#
# selected.each do |sale|
#   puts "ID: #{sale.id}, Time: #{sale.purchase_time}"
# end
#
# puts
# puts selected.length
