require 'rails_helper'

describe Offer do
  let(:product) { create :product_with_single_variant }
  let(:product_offer) { create :product_with_single_variant }
  it "actual if has discount and both products are available" do
    offer = Offer.new product: product, product_offer: product_offer, price: 10
    expect(offer).to be_actual
  end

  context 'when one of products is unavailable' do
    let(:product) { create :unavailable_product }
    let(:product_offer) { create :product }
    it 'is not actual' do
      offer = Offer.new product: product, product_offer: product_offer, price: 10
      expect(offer).to_not be_actual
    end
  end
  context 'when has no discount' do
    let(:product) { create :unavailable_product }
    let(:product_offer) { create :product }
    it 'is not actual' do
      offer = Offer.new product: product, product_offer: product_offer, price: nil
      expect(offer).to_not be_actual
    end
  end
end
