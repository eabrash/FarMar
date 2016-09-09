require_relative "Spec_helper"
require_relative "../lib/farmar_sale.rb"

describe "Testing methods of FarMar::Sale class" do

  it "Confirm that a Sale object knows and can return its source file" do
    sale = FarMar::Sale.new(["1","9290","2013-11-07 04:34:56 -0800","1","1"])
    expect(sale.source_file).must_equal("./support/sales.csv")
  end

  it "Confirm that the .all method returns an array containing the correct number of Sales" do
    expect(FarMar::Sale.all.length).must_equal(12001)
  end

  it "Confirm that the first Sale in the array returned by .all has the correct identifying information" do
    expect(FarMar::Sale.all[0].id).must_equal(1)
    expect(FarMar::Sale.all[0].amount).must_equal(9290)
    expect(FarMar::Sale.all[0].purchase_time).must_equal(DateTime.parse("2013-11-07 04:34:56 -0800"))
    expect(FarMar::Sale.all[0].vendor_id).must_equal(1)
    expect(FarMar::Sale.all[0].product_id).must_equal(1)
  end

  it "Confirm that the last Sale in the array returned by .all has the correct identifying information" do
    expect(FarMar::Sale.all[-1].id).must_equal(12001)
    expect(FarMar::Sale.all[-1].amount).must_equal(8923)
    expect(FarMar::Sale.all[-1].purchase_time).must_equal(DateTime.parse("2013-11-10 15:22:35 -0800"))
    expect(FarMar::Sale.all[-1].vendor_id).must_equal(2690)
    expect(FarMar::Sale.all[-1].product_id).must_equal(8192)
  end

  it "Confirm that ID-based search for a Sale returns the correct Sale object" do
    expect(FarMar::Sale.find(12000).amount).must_equal(7773)
  end

  it "Confirm that a Sale object can return its associated Vendor object" do
    sale1 = FarMar::Sale.new(["1","9290","2013-11-07 04:34:56 -0800","1","1"])
    expect(sale1.vendor.id).must_equal(1)
    expect(sale1.vendor.name).must_equal("Feil-Farrell")
    sale2 = FarMar::Sale.new(["9","9128","2013-11-13 01:48:15 -0800","3","4"])
    expect(sale2.vendor.id).must_equal(3)
    expect(sale2.vendor.name).must_equal("Breitenberg Inc")
  end

  it "Confirm that a Sale object can return its associated Product object" do
    sale1 = FarMar::Sale.new(["26","9690","2013-11-09 21:45:12 -0800","5","9"])
    expect(sale1.product.id).must_equal(9)
    expect(sale1.product.name).must_equal("Large Mushrooms")
    sale2 = FarMar::Sale.new(["27","2851","2013-11-13 04:14:40 -0800","5","10"])
    expect(sale2.product.id).must_equal(10)
    expect(sale2.product.name).must_equal("Black Apples")
  end

  it "Confirm that the set of Sale objects with timestamps between two specified timepoints is correctly returned" do
    early_sales = FarMar::Sale.between(DateTime.parse("2013-11-06 08:00:00 -08:00"), DateTime.parse("2013-11-06 09:00:00 -08:00"))
    expect(early_sales.length).must_equal(33)
    too_early_sales = FarMar::Sale.between(DateTime.parse("2013-11-06 08:00:00 -08:00"), DateTime.parse("2013-11-06 08:30:00 -08:00"))
    expect(too_early_sales).must_equal([])
    sales_within_internal_range = FarMar::Sale.between(DateTime.parse("2013-11-06 08:45:00 -08:00"), DateTime.parse("2013-11-06 09:00:00 -08:00"))
    expect(sales_within_internal_range.length).must_equal(22)
  end

  it "Return the correct set of sales for a date" do
    sales_of_day = FarMar::Sale.by_date(DateTime.parse("2013-11-06"))
    expect(sales_of_day.length).must_equal(1041)
    expect(sales_of_day[0].id).must_equal(4)
    expect(sales_of_day[-1].id).must_equal(11980)
  end

end
