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

end
