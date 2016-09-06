require_relative "Spec_helper"
require_relative "../lib/farmar_market.rb"

describe "Testing if objects of Market class know their source file" do

  it "Confirm that a Market object knows and can return its source file" do
    market = FarMar::Market.new("test")
    expect(market.source_file).must_equal("../support/markets.csv")
  end

end
