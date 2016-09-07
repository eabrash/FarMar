require_relative "../far_mar"

class FarMar::Market

  MARKET_FILE = "./support/markets.csv"  # Source file

  attr_reader :id, :name, :address, :city, :county, :state, :zip

  def initialize (line)

    @id = Integer(line[0])
    @name = line[1]
    @address = line[2]
    @city = line[3]
    @county = line[4]
    @state = line[5]
    @zip = line[6]

    return self

  end

  def self.all

    array_of_markets = CSV.read(MARKET_FILE)
    markets = []

    array_of_markets.each do |line|
      markets << FarMar::Market.new(line)
    end

    return markets

  end

  def self.find(id)

    markets = self.all

    markets.each do |market|
      if market.id == id
        return market
      end
    end

    return nil  # If market is not found

  end

  def source_file
    return MARKET_FILE
  end

end
