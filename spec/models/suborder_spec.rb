require 'rails_helper'

describe Suborder do

  let(:variant) { create :variant }

  it "calculate total" do
    suborder = Suborder.new variant: variant, discount: 10
    suborder.validate
    expect(suborder.total).to eq(variant.price - 10)
  end

  context "when save" do
    it "memorize current variant price" do
      suborder = Suborder.new variant: variant
      suborder.save
      expect(suborder.price).to eq(variant.price)
    end
  end
  describe "merge_with" do
    let(:variant) { create :variant }
    let(:suborder_with_same_variant) { create :suborder, variant: variant, quantity: 2 }
    it "merge suborder with same variant" do
      suborder = Suborder.new variant: variant, quantity: 3
      suborder.merge_with suborder_with_same_variant
      expect(suborder.quantity).to eql(5)
    end
  end
end
