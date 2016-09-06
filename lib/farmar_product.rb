require_relative "../far_mar"

class FarMar::Product

  PRODUCT_FILE = "../support/products.csv"

  @@products = []

  def self.read_csv
    # Iterates through csv file of vendors
    #   Initializes a Product object for each line
    #   Stores the Product object in @@products array
  end

  def initialize (line)
    # Makes new instance of Product given the data in the provided line
    # Returns the new instance of Product
  end

  def source_file
    return PRODUCT_FILE
  end

end
