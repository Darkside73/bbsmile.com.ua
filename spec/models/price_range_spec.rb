require 'spec_helper'

describe PriceRange do
  it "nilify from (to) if it blank" do
    price_range = build :price_range
    price_range.from = ''
    price_range.save
    price_range.from.should be_nil
  end
end
