require_relative "Spec_helper"
require_relative "../lib/farmar_vendor.rb"

describe "Testing methods of FarMar::Vendor class" do

  it "Confirm that a Vendor object knows and can return its source file" do
    vendor = FarMar::Vendor.new(["1",	"Feil-Farrell",	"8",	"1"])
    expect(vendor.source_file).must_equal("./support/vendors.csv")
  end

  it "Confirm that the .all method returns an array containing the correct number of vendors" do
    expect(FarMar::Vendor.all.length).must_equal(2690)
  end

  it "Confirm that the first vendor in the array returned by .all has the correct identifying information" do
    expect(FarMar::Vendor.all[0].id).must_equal(1)
    expect(FarMar::Vendor.all[0].name).must_equal("Feil-Farrell")
    expect(FarMar::Vendor.all[0].num_employees).must_equal(8)
    expect(FarMar::Vendor.all[0].market_id).must_equal(1)
  end

  it "Confirm that the last vendor in the array returned by .all has the correct identifying information" do
    expect(FarMar::Vendor.all[-1].id).must_equal(2690)
    expect(FarMar::Vendor.all[-1].name).must_equal("Mann-Lueilwitz")
    expect(FarMar::Vendor.all[-1].num_employees).must_equal(4)
    expect(FarMar::Vendor.all[-1].market_id).must_equal(500)
  end

  it "Confirm that ID-based search for a vendor returns the correct Vendor object" do
    expect(FarMar::Vendor.find(2688).name).must_equal("Hauck-Jaskolski")
  end

  it "Confirm that a Vendor returns its correct Market object" do
    vendor = FarMar::Vendor.new(["1",	"Feil-Farrell",	"8",	"1"])
    expect(vendor.market.id).must_equal(FarMar::Market.find(1).id)
  end

  it "Confirm that a Vendor returns its correct associated Product objects" do
    vendor = FarMar::Vendor.new(["4","Kris and Sons","5","1"])
    expect(vendor.products.length).must_equal(3)
    expect(vendor.products[0].id).must_equal(5)
    expect(vendor.products[0].name).must_equal("Green Apples")
    expect(vendor.products[-1].id).must_equal(7)
    expect(vendor.products[-1].name).must_equal("Quaint Beef")
  end

  it "Confirm that a Vendor returns its correct associated Sale objects" do
    vendor = FarMar::Vendor.new(["4","Kris and Sons","5","1"])
    expect(vendor.sales.length).must_equal(5)
    expect(vendor.sales[0].id).must_equal(17)
    expect(vendor.sales[0].amount).must_equal(3442)
    expect(vendor.sales[-1].id).must_equal(21)
    expect(vendor.sales[-1].amount).must_equal(8963)
  end

  it "Confirm that a Vendor object returns its correct associated revenue" do
    vendor = FarMar::Vendor.new(["4","Kris and Sons","5","1"])
    expect(vendor.revenue).must_equal(26866)
  end

  it "Confirm that a market id can be used to fish up the correct set of associated vendors" do
    vendors = FarMar::Vendor.by_market(1)
    expect(vendors[0].id).must_equal(1)
    expect(vendors[0].name).must_equal("Feil-Farrell")
    expect(vendors[-1].id).must_equal(6)
    expect(vendors[-1].name).must_equal("Zulauf and Sons")
    expect(vendors.length).must_equal(6)
  end

  it "Returns the correct per-day total revenue for a Vendor" do
    vendor = FarMar::Vendor.new(["4","Kris and Sons","5","1"])
    expect(vendor.revenue(DateTime.parse("2013-11-11"))).must_equal(9035)
    expect(vendor.revenue(DateTime.parse("2013-11-13"))).must_equal(0)
  end

  it "Returns the top n vendors ranked by revenue" do
    skip
    expect(FarMar::Vendor.most_revenue(1).length).must_equal(1)
    expect(FarMar::Vendor.most_revenue(1)[0].id).must_equal(734)
    expect(FarMar::Vendor.most_revenue(5).length).must_equal(5)
    expect(FarMar::Vendor.most_revenue(300)[-1].id).must_equal(2320)
    expect(FarMar::Vendor.most_revenue(3000).length).must_equal(2690)
  end

  it "Returns the top n vendors ranked by number of items sold (number of sales)" do
    skip
    expect(FarMar::Vendor.most_items(1).length).must_equal(5)
    expect(FarMar::Vendor.most_items(1)[0].id).must_equal(734)
    expect(FarMar::Vendor.most_items(254).length).must_equal(5254)
    expect(FarMar::Vendor.most_items(254)[-1].id).must_equal(3)
    expect(FarMar::Vendor.most_items(3000).length).must_equal(2690)
  end

  it "Returns the total revenue for a date" do
    skip
    expect(FarMar::Vendor.revenue(DateTime.parse("2013-11-11"))).must_equal(8575374)
    expect(FarMar::Vendor.revenue(DateTime.parse("1900-11-11"))).must_equal(0)
  end

end
