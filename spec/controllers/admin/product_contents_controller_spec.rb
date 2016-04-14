require 'rails_helper'

describe Admin::ProductContentsController do
  describe 'POST create' do
    let(:product) { create :product }
    it 'create Content' do
      expect {
        post :create, params: { product_id: product.id, content: { text: 'new content' } }
        product.reload
      }.to change { product.content }
      expect(flash[:notice]).to have_content(/saved/i)
      expect redirect_to([:content, :admin, product])
    end
  end
  describe 'PUT update' do
    let(:product) { create :product_with_content}
    it 'update Content' do
      expect {
        post :update, params: { id: product.content.id, content: { text: 'new content' } }
        product.reload
      }.to change { product.content.text }
      expect(flash[:notice]).to have_content(/saved/i)
      expect redirect_to([:content, :admin, product])
    end
  end
end
