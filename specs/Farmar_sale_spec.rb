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
    expect(FarMar::Sale.all[0].purchase_time).must_equal(Time.new("2013-11-07 04:34:56 -0800"))
    expect(FarMar::Sale.all[0].vendor_id).must_equal(1)
    expect(FarMar::Sale.all[0].product_id).must_equal(1)
  end

  it "Confirm that the last Sale in the array returned by .all has the correct identifying information" do
    expect(FarMar::Sale.all[-1].id).must_equal(12001)
    expect(FarMar::Sale.all[-1].amount).must_equal(8923)
    expect(FarMar::Sale.all[-1].purchase_time).must_equal(Time.new("2013-11-12 02:03:31 -0800"))
    expect(FarMar::Sale.all[-1].vendor_id).must_equal(2690)
    expect(FarMar::Sale.all[-1].product_id).must_equal(8192)
  end

  it "Confirm that ID-based search for a Sale returns the correct Sale object" do
    expect(FarMar::Sale.find(12000).amount).must_equal(7773)
  end

end
