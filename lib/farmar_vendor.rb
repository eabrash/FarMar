require_relative "../far_mar"

class FarMar::Vendor

  VENDOR_FILE = "../support/vendors.csv"

  @@vendors = []

  def self.read_csv
    # Iterates through csv file of vendors
    #   Initializes a Vendor object for each line
    #   Stores the Vendor object in @@vendors array
  end

  def initialize (line)
    # Makes new instance of Vendor given the data in the provided line
    # Returns the new instance of Vendor
  end

  def source_file
    return VENDOR_FILE
  end

end
