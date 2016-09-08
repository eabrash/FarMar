require_relative "Spec_helper"
require_relative "../lib/farmar_market.rb"

describe "Testing methods of FarMar::Market class" do

  it "Confirm that a Market object knows and can return its source file" do
    market = FarMar::Market.new(["1", "People's Co-op Farmers Market", "30th and Burnside", "Portland",	"Multnomah",	"Oregon",	"97202"])
    expect(market.source_file).must_equal("./support/markets.csv")
  end

  it "Confirm that the .all method returns an array containing the correct number of markets" do
    expect(FarMar::Market.all.length).must_equal(500)
  end

  it "Confirm that the first market in the array returned by .all has the correct identifying information" do
    expect(FarMar::Market.all[0].id).must_equal(1)
    expect(FarMar::Market.all[0].name).must_equal("People's Co-op Farmers Market")
    expect(FarMar::Market.all[0].address).must_equal("30th and Burnside")
    expect(FarMar::Market.all[0].city).must_equal("Portland")
    expect(FarMar::Market.all[0].county).must_equal("Multnomah")
    expect(FarMar::Market.all[0].state).must_equal("Oregon")
    expect(FarMar::Market.all[0].zip).must_equal("97202")
  end

  it "Confirm that the last market in the array returned by .all has the correct identifying information" do
    expect(FarMar::Market.all[-1].id).must_equal(500)
    expect(FarMar::Market.all[-1].name).must_equal("Montefiore Medical Center Farmers Market_Thursday")
    expect(FarMar::Market.all[-1].address).must_equal("111 E. 210th Street")
    expect(FarMar::Market.all[-1].city).must_equal("Bronx")
    expect(FarMar::Market.all[-1].county).must_equal("Bronx")
    expect(FarMar::Market.all[-1].state).must_equal("New York")
    expect(FarMar::Market.all[-1].zip).must_equal("10467")
  end

  it "Confirm that ID-based search for a market returns the correct market object" do
    expect(FarMar::Market.find(2).name).must_equal("Silverdale Farmers Market")
  end

  it "A Market object can return the associated Vendor objects" do
    market = FarMar::Market.new(["1", "People's Co-op Farmers Market", "30th and Burnside", "Portland",	"Multnomah",	"Oregon",	"97202"])
    expect(market.vendors[0].id).must_equal(1)
    expect(market.vendors[0].name).must_equal("Feil-Farrell")
    expect(market.vendors[-1].id).must_equal(6)
    expect(market.vendors[-1].name).must_equal("Zulauf and Sons")
    expect(market.vendors.length).must_equal(6)
  end

  it "A Market object can return the associated Product objects" do
    market = FarMar::Market.new(["1", "People's Co-op Farmers Market", "30th and Burnside", "Portland",	"Multnomah",	"Oregon",	"97202"])
    expect(market.products.length).must_equal(13)
    expect(market.products[0].name).must_equal("Dry Beets")
    expect(market.products[-1].name).must_equal("Curved Pretzel")
  end

  it "A set of markets can be searched for a term in the name field, and the matching Market objects returned" do
    school_results = FarMar::Market.search("school")
    expect(school_results.length).must_equal(3)
    expect(school_results.select{|result| result.id == 75}[0].name).must_equal("Fox School Farmers Market")
  end

  it "Correctly identifies the vendor with the highest overall revenue in the market" do
    market = FarMar::Market.new(["1", "People's Co-op Farmers Market", "30th and Burnside", "Portland",	"Multnomah",	"Oregon",	"97202"])
    expect(market.prefered_vendor.id).must_equal(5)
    expect(market.prefered_vendor.name).must_equal("Reynolds, Schmitt and Klocko")
  end

  it "Correctly identifies the vendor with the highest revenue in the market for a given date" do
    market = FarMar::Market.new(["1", "People's Co-op Farmers Market", "30th and Burnside", "Portland",	"Multnomah",	"Oregon",	"97202"])
    expect(market.prefered_vendor(DateTime.parse("2013-11-13")).id).must_equal(1)
    expect(market.prefered_vendor(DateTime.parse("2013-11-13")).name).must_equal("Feil-Farrell")
  end

  it "Correctly identifies the vendor with the lowest overall revenue in the market" do
    market = FarMar::Market.new(["1", "People's Co-op Farmers Market", "30th and Burnside", "Portland",	"Multnomah",	"Oregon",	"97202"])
    expect(market.worst_vendor.id).must_equal(6)
    expect(market.worst_vendor.name).must_equal("Zulauf and Sons")
  end

  it "Correctly identifies the vendor with the lowest revenue in the market for a given date" do
    market = FarMar::Market.new(["1", "People's Co-op Farmers Market", "30th and Burnside", "Portland",	"Multnomah",	"Oregon",	"97202"])
    expect(market.worst_vendor(DateTime.parse("2013-11-13")).id).must_equal(5)
    expect(market.worst_vendor(DateTime.parse("2013-11-13")).name).must_equal("Reynolds, Schmitt and Klocko")
  end

end
