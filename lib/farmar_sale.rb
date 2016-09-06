require_relative "../far_mar"

class FarMar::Sale

  SALE_FILE = "../support/sales.csv"

  @@sales = []

  def self.read_csv
    # Iterates through csv file of sales
    #   Initializes a Sale object for each line
    #   Stores the Sale object in @@sales array
  end

  def initialize (line)
    # Makes new instance of Sale given the data in the provided line
    # Returns the new instance of Sale
  end

  def source_file
    return SALE_FILE
  end

end
