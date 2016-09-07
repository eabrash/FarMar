require_relative "Spec_helper"
require_relative "../lib/farmar_product.rb"

describe "Testing methods of FarMar::Product class" do


  it "Confirm that a Product object knows and can return its source file" do
    product = FarMar::Product.new(["1",	"Dry Beets",	"1"])
    expect(product.source_file).must_equal("./support/products.csv")
  end

  it "Confirm that the .all method returns an array containing the correct number of vendors" do
    expect(FarMar::Product.all.length).must_equal(8193)
  end

  it "Confirm that the first Product in the array returned by .all has the correct identifying information" do
    expect(FarMar::Product.all[0].id).must_equal(1)
    expect(FarMar::Product.all[0].name).must_equal("Dry Beets")
    expect(FarMar::Product.all[0].vendor_id).must_equal(1)
  end

  it "Confirm that the last Product in the array returned by .all has the correct identifying information" do
    expect(FarMar::Product.all[-1].id).must_equal(8193)
    expect(FarMar::Product.all[-1].name).must_equal("Cruel Beef")
    expect(FarMar::Product.all[-1].vendor_id).must_equal(2690)
  end

  it "Confirm that ID-based search for a vendor returns the correct Product object" do
    expect(FarMar::Product.find(8190).name).must_equal("High Beef")
  end

end
