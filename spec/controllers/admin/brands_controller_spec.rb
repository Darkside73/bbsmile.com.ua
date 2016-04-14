require 'rails_helper'

describe Admin::BrandsController do
  describe 'GET index' do
    let(:brands) { create_list :brand, 3 }
    it 'assings brands' do
      get :index
      expect(assigns :brands).to be
    end
  end
  describe 'GET new' do
    it 'assigns new brand' do
      get :new
      expect(assigns :brand).to be_a_new(Brand)
    end
  end
  describe 'POST create' do
    it 'create brand and redirect to index' do
      post :create,
        params: {
          brand: {
            name: 'some brand',
            content_attributes: attributes_for(:content)
          }
        }
      expect(flash[:notice]).to have_content(/created/i)
    end
  end
  describe 'GET edit' do
    let(:brand) { create :brand }
    it 'assigns not new brand' do
      get :edit, params: { id: brand.id }
      expect(assigns :brand).to_not be_a_new(Brand)
    end
  end
  describe 'PUT update' do
    let(:brand) { create :brand }
    it 'update brand and redirect to brands' do
      put :update, params: { id: brand.id, brand: { name: 'brand name' } }
      expect(flash[:notice]).to have_content(/updated/i)
      expect redirect_to([:admin, :brands])
      expect { brand.reload }.to change { brand.name }
    end
  end

  describe 'DELETE' do
    it 'destroy Brand' do
      brand = create :brand
      expect {
        delete :destroy, xhr: true, params: { id: brand.id }
        brand.reload
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
