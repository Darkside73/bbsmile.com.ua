require 'rails_helper'

describe Admin::BrandsController do
  describe 'GET index' do
    let(:brands) { create_list :brand, 3 }
    it 'assings brands' do
      get :index
      assigns(:brands).should be
    end
  end
  describe 'GET new' do
    it 'assigns new brand' do
      get :new
      assigns(:brand).should be_a_new(Brand)
    end
  end
  describe 'POST create' do
    it 'create brand and redirect to index' do
      post :create, brand: {
        name: 'some brand',
        content_attributes: attributes_for(:content)
      }
      flash[:notice].should have_content(/created/i)
    end
  end
  describe 'GET edit' do
    let(:brand) { create :brand }
    it 'assigns not new brand' do
      get :edit, id: brand.id
      assigns(:brand).should_not be_a_new(Brand)
    end
  end
  describe 'PUT update' do
    let(:brand) { create :brand }
    it 'update brand and redirect to brands' do
      put :update, id: brand.id, brand: { name: 'brand name' }
      flash[:notice].should have_content(/updated/i)
      response.should redirect_to([:admin, :brands])
      expect { brand.reload }.to change { brand.name }
    end
  end

  describe 'DELETE' do
    it 'destroy Brand' do
      brand = create :brand
      expect {
        xhr :delete, :destroy, id: brand.id
        brand.reload
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
