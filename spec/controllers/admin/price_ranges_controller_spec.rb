require 'rails_helper'

describe Admin::PriceRangesController do
  describe 'GET index' do
    let(:category) { create :category }
    it 'assings category and new price range' do
      get :index, params: { category_id: category.id }
      expect(assigns :category).to be
      expect(assigns :price_range).to be_a_new(PriceRange)
    end
  end
  describe 'POST create' do
    let(:category) { create :category}
    it 'create price_range and redirect to index' do
      post :create,
        params: {
          category_id: category.id, price_range: {
            from: 1000, to: 3000
          }
        }
      expect(flash[:notice]).to have_content(/created/i)
      expect redirect_to([:admin, category, :price_ranges])
    end
  end
  describe 'PUT update' do
    let(:price_range) { create :price_range }
    it 'update price range and redirect to index' do
      put :update, params: { id: price_range.id, price_range: { to: '' } }
      expect(flash[:notice]).to have_content(/updated/i)
      expect redirect_to(admin_category_price_ranges_url(price_range.category))
      expect { price_range.reload }.to change { price_range.to }
    end
  end
  describe 'DELETE' do
    let(:price_range) { create :price_range }
    it 'destroy price range' do
      expect {
        delete :destroy, xhr: true, params: { id: price_range.id }
        price_range.reload
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
