require 'rails_helper'

describe CartController do
  before :each do
    session[:cart] = Order.new
  end
  describe 'POST add_item' do
    let(:variant) { create(:variant) }
    it 'add product variant to cart' do
      expect {
        xhr :post, :add_item, variant_id: variant.id, quantity: 2
      }.to change { session[:cart].size }.by(2)
      expect(response).to be_success
    end
    it 'not add invalid item to cart' do
      expect {
        xhr :post, :add_item, variant_id: 'foo', quantity: 'bar'
      }.to_not change { session[:cart].size }
      expect(response).to_not be_success
    end
    it "merge items with same product variant" do
      xhr :post, :add_item, variant_id: variant.id, quantity: 2
      xhr :post, :add_item, variant_id: variant.id, quantity: 1
      expect(session[:cart].suborders.size).to eq(1)
    end
    context 'when offer used' do
      let(:offer) { create :offer }
      it 'add discount to subborder' do
        xhr :post, :add_item,
          variant_id: offer.product.master_variant.id, quantity: 1
        xhr :post, :add_item,
          variant_id: offer.product_offer.master_variant.id,
          quantity: 1,
          offer_id: offer.id
        expect(session[:cart].suborders.second.discount).to_not eq(0)
      end
    end
  end
  describe 'DELETE delete_item' do
    before do
      session[:cart].suborders = [build(:suborder), build(:suborder)]
    end
    it 'delete product variant from cart' do
      expect {
        xhr :delete, :delete_item, index: 0
      }.to change { session[:cart].size }.by(-1)
      expect {
        xhr :delete, :delete_item, index: 0
      }.to change { session[:cart].total }
    end
  end
  describe "GET items" do
    it "return cart items" do
      xhr :get, :index
      expect(response).to be_success
    end
  end
  describe "GET change quantity" do
    before do
      session[:cart].suborders = [build(:suborder), build(:suborder)]
    end
    it "change item quantity" do
      xhr :get, :update, index: 0, quantity: 3
      expect(session[:cart].suborders.first.quantity).to eq(3)
    end
  end
end
