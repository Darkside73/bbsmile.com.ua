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
      end
    end
    context 'with invalid data' do
      it 'not redirect to index' do
        post :create, category: { title: Faker::Name.title }
        response.should be_success
      end
    end
  end
  describe 'GET edit' do
    let(:category) { create :category, title: Faker::Name.title }
    it 'assigns not new category' do
      get :edit, id: category.id
      assigns(:category).should_not be_a_new(Category)
    end
  end
  describe 'PUT update' do
    let(:category) { create :category, title: Faker::Name.title }
    it 'update category and redirect to index' do
      put :update, id: category.id, category: {title: 'New title'}
      expect { category.reload }.to change { category.title }
      flash[:notice].should have_content(/updated/i)
      response.should redirect_to([:admin, category])
    end
  end
  describe 'POST create_subcategory' do
    let(:category) { create :category, title: Faker::Name.title }
    it 'create subcategory' do
      post :create_subcategory, id: category.id, category: { title: Faker::Name.title, url: Faker::Lorem.word }
      flash[:notice].should have_content(/created/i)
    end
  end
end