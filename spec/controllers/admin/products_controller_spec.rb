require 'spec_helper'

describe Admin::ProductsController do
  describe 'GET index' do
    let(:products) { create_list :products, 3 }
    it 'assings products' do
      get :index
      assigns(:products).should be
    end
  end
  describe 'GET new' do
    it 'assigns new product and leaf categories' do
      get :new
      assigns(:product).should be_a_new(Product)
      assigns(:leaf_categories).should be_a(Array)
    end
  end
  describe 'POST create' do
    let(:category) { create :category}
    it 'create product and redirect to index' do
      post :create, product: {
        category_id: category.id,
        page_attributes: attributes_for(:page)
      }
      flash[:notice].should have_content(/created/i)
    end
  end
  # describe 'GET edit' do
  #   let(:category) { create :category }
  #   it 'assigns not new category' do
  #     get :edit, id: category.id
  #     assigns(:category).should_not be_a_new(Category)
  #   end
  # end
  # describe 'PUT update' do
  #   let(:category) { create :category }
  #   it 'update category and redirect to categories if category is root' do
  #     put :update, id: category.id, category: { page_attributes: attributes_for(:page) }
  #     flash[:notice].should have_content(/updated/i)
  #     response.should redirect_to([:admin, :categories])
  #     expect { category.reload }.to change { category.page.title }
  #   end
  # describe 'DELETE' do
  #   it 'destroy Category' do
  #     category = create :category
  #     expect {
  #       xhr :delete, :destroy, id: category.id
  #       category.reload
  #     }.to raise_error(ActiveRecord::RecordNotFound)
  #   end
  # end
end