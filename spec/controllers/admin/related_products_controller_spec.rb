require 'spec_helper'

describe Admin::RelatedProductsController do
  describe 'POST create' do
    let(:product) { create :product }
    let(:related) { create :product }
    it 'create relation between products' do
      expect {
        xhr :post, :create, format: :json,
            product_id: product.id,
            related_product: { related_id: related.id, type_of: :suggested }
        response.should be_success
        product.reload
      }.to change { product.suggested_products.count }.by(1)
    end
  end
  describe 'GET show' do
    let(:related_product) { create :related_product }
    it 'show relation between products' do
      xhr :get, :show, id: related_product.id, format: :html
      response.should be_success
      response.should render_template(:show)
    end
  end
  describe 'DELETE' do
    let(:product) { create :product_with_related_products }
    it 'destroy relation between products' do
      related = product.related_products.sample
      expect {
        xhr :delete, :destroy, id: related.id
        response.should be_success
        related.reload
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
