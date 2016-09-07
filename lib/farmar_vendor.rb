require_relative "../far_mar"

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

  def self.all

    array_of_vendors = CSV.read(VENDOR_FILE)
    vendors = []

    array_of_vendors.each do |line|
      vendors << FarMar::Vendor.new(line)
    end

    return vendors
  end

  def self.find(id)

    vendors = self.all

    vendors.each do |vendor|
      if vendor.id == id
        return vendor
      end
    end

    return nil  # If sale is not found

  end

  def source_file
    return VENDOR_FILE
  end

end
