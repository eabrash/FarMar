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

  it "Confirm that ID-based search for a Product returns the correct Product object" do
    expect(FarMar::Product.find(8190).name).must_equal("High Beef")
  end

  it "Confirm that a Product object can return its associated Vendor object" do
    product = FarMar::Product.new(["15","Comfortable Pretzel","8"])
    expect(product.vendor.id).must_equal(8)
    expect(product.vendor.name).must_equal("Stamm Inc")
  end

  it "Confirm that a Product object can return its associated Sale objects" do
    product = FarMar::Product.new(["7","Quaint Beef","4"])
    expect(product.sales.length).must_equal(2)
    expect(product.sales[0].id).must_equal(17)
    expect(product.sales[1].id).must_equal(21)
  end

  it "Confirm that a Product object correctly returns the number of sales associated with it" do
    product1 = FarMar::Product.new(["7","Quaint Beef","4"])
    expect(product1.number_of_sales).must_equal(2)
    product2 = FarMar::Product.new(["9","Large Mushrooms","5"])
    expect(product2.number_of_sales).must_equal(3)
  end

  it "Confirm that the Product class can return all of the Product objects associated with a given vendor id" do
    products = FarMar::Product.by_vendor(10)
    expect(products.length).must_equal(5)
    expect(products[0].id).must_equal(23)
    expect(products[0].name).must_equal("Calm Carrots")
    expect(products[-1].id).must_equal(27)
    expect(products[-1].name).must_equal("Broken Beets")
  end

end
