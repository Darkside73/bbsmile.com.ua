require 'spec_helper'

describe PriceRange do
  it "nilify from (to) if it blank" do
    price_range = build :price_range
    price_range.from = ''
    price_range.save
    price_range.from.should be_nil
  end
  it "fails validation if range from is greather than range to" do
    expect(PriceRange.new(from: 10, to: 5)).to have(1).error_on(:from)
  end
  it "valid if range from is empty" do
    expect(PriceRange.new(from: '', to: 5)).to be_valid
  end
end
