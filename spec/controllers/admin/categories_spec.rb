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
    it 'remove spaces around' do
      put :update, id: category.id, category: {title: "      #{category.title}      "}
      expect { category.reload }.to_not change { category.title }
    end
  end
  describe 'POST create_subcategory' do
    let(:category) { create :category, title: Faker::Name.title }
    it 'create subcategory' do
      post :create_subcategory, id: category.id, category: { title: Faker::Name.title, url: Faker::Lorem.word }
      flash[:notice].should have_content(/created/i)
    end
  end
  describe 'POST sort' do
    let(:category) { create :category, title: Faker::Name.title, subcategories: [Faker::Name.title, Faker::Name.title] }
    it 'put categories in desired order' do
      first_subcategory = category.children.first
      second_subcategory = category.children.second
      expect {
        expect {
          post :sort, id: second_subcategory.id, position: 1
          first_subcategory.reload
          second_subcategory.reload
        }.to change { second_subcategory.position }.from(2).to(1)
      }.to change { first_subcategory.position }.from(1).to(2)
      response.should be_success
    end
  end
end