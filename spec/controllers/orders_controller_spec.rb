require 'rails_helper'

describe OrdersController do
  describe 'POST create' do
    let(:product) { create :product_with_variants}
    it 'creates order' do
      xhr :post, :create, order: {
        variant_id: product.variants.sample.id,
        user_attributes: attributes_for(:user)
      }
      flash[:success].should have_content(/created/i)
    end
  end
end
