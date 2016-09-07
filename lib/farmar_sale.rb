require_relative "../far_mar"

class FarMar::Sale

  SALES_FILE = "./support/sales.csv"

  attr_accessor :id, :amount, :purchase_time, :vendor_id, :product_id

  def initialize (line)

    @id = Integer(line[0])
    @amount = Integer(line[1].to_f.round(0))
    @purchase_time = Time.new(line[2])
    @vendor_id = Integer(line[3])
    @product_id = Integer(line[4])

    return self

  end

  def self.all

    array_of_sales = CSV.read(SALES_FILE)
    sales = []

    array_of_sales.each do |line|
      sales << FarMar::Sale.new(line)
    end

    return sales

  end

  def self.find(id)

    sales = self.all

    sales.each do |sale|
      if sale.id == id
        return sale
      end
    end

    return nil  # If sale is not found

  end

  def source_file
    return SALES_FILE
  end

end
