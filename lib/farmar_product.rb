require_relative "../far_mar"

class FarMar::Product

  PRODUCT_FILE = "./support/products.csv"

  attr_accessor :id, :name, :vendor_id

  def initialize (line)

    @id = Integer(line[0])
    @name = line[1]
    @vendor_id = Integer(line[2])

    return self

  end

  def self.all

    array_of_products = CSV.read(PRODUCT_FILE)
    products = []

    array_of_products.each do |line|
      products << FarMar::Product.new(line)
    end

    return products

  end

  def self.find(id)

    products = self.all

    products.each do |product|
      if product.id == id
        return product
      end
    end

    return nil  # If product is not found

  end

  def source_file
    return PRODUCT_FILE
  end

end
