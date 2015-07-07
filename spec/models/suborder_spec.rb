require 'rails_helper'

describe Suborder do
  context "when save" do
    let(:variant) { create :variant }
    it "memorize current variant price" do
      suborder = build :suborder, variant: variant
      suborder.save
      expect(suborder.price).to eq(variant.price)
    end
  end
end
