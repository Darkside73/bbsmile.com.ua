require 'rails_helper'

describe CartController do
  describe 'POST add_item' do
    before :each do
      session[:cart] = Order.new
    end
    let(:variant) { create(:variant) }
    it 'add product variant to cart' do
      expect {
        xhr :post, :add_item, variant_id: variant.id, quantity: 2
      }.to change { session[:cart].size }.by(1)
      expect(response).to be_success
    end
    it 'not add invalid item to cart' do
      expect {
        xhr :post, :add_item, variant_id: 'foo', quantity: 'bar'
      }.to_not change { session[:cart].size }
      expect(response).to_not be_success
    end
  end
  describe 'DELETE delete_item' do
    before do
      session[:cart] = create :order
    end
    it 'delete product variant from cart' do
      expect {
        xhr :delete, :delete_item, index: 0
      }.to change { session[:cart].size }.by(-1)
    end
  end
end
