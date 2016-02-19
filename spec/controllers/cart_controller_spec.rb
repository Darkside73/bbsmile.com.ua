require 'rails_helper'

describe CartController do
  before :each do
    session[:cart] = []
  end
  describe 'POST add_item' do
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
    end
    it "merge items with same product variant" do
      xhr :post, :add_item, variant_id: variant.id, quantity: 2
      xhr :post, :add_item, variant_id: variant.id, quantity: 1
      expect(session[:cart].size).to eq(1)
    end
  end
  describe 'DELETE delete_item' do
    before do
      session[:cart] = [
        { variant_id: create(:variant).id, quantity: 1 },
        { variant_id: create(:variant).id, quantity: 2 }
      ]
    end
    it 'delete product variant from cart' do
      expect {
        xhr :delete, :delete_item, index: 0
      }.to change { session[:cart].size }.by(-1)
    end
  end
  describe "GET items" do
    it "return cart items" do
      xhr :get, :index
      expect(response).to be_success
    end
  end
  describe "GET change quantity" do
    let(:variant) { create(:variant) }
    it "change item quantity" do
      session[:cart] = [{ variant_id: variant.id, quantity: 2 }]
      xhr :get, :update, index: 0, quantity: 3
      expect(session[:cart].first).to include("quantity" => 3)
    end
  end
end
