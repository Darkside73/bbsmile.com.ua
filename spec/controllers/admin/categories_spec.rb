require 'spec_helper'

describe Admin::CategoriesController do
  describe 'GET index' do
    let(:categories) { create_list :category, 3, title: Faker::Name.title }
    it 'assings categories' do
      get :index
      assigns(:categories).should be
    end
    it 'assings category' do
      get :show, id: categories.first.id
      assigns(:category).should be
    end
  end
  describe 'GET new' do
    it 'assigns new category' do
      get :new
      assigns(:category).should be_a_new(Category)
    end
  end
  describe 'POST create' do
    context 'with valid data' do
      it 'create category and redirect to index' do
        post :create, category: { title: Faker::Name.title, url: Faker::Lorem.word }
        flash[:notice].should have_content(/created/i)
        response.should redirect_to(admin_categories_url)
      end
    end
    context 'with invalid data' do
      it 'not redirect to index' do
        post :create, category: { title: Faker::Name.title }
        response.should be_success
      end
    end
  end
end