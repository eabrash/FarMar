require_relative "../far_mar"

class FarMar::Market

  MARKET_FILE = "../support/markets.csv"

  @@markets = []

  def self.read_csv
    # Iterates through csv file of markets
    #   Initializes a Market object for each line
    #   Stores the Market object in @@markets array
  end

  def initialize (line)
    # Makes new instance of Market given the data in the provided line
    # Returns the new instance of Market
  end

  def source_file
    return MARKET_FILE
  end

end
