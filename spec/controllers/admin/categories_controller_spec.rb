require 'spec_helper'

describe Admin::CategoriesController do
  describe 'GET index' do
    let(:categories) { create_list :category, 3 }
    it 'assings categories' do
      get :index
      assigns(:categories).should be
    end
  end
  describe 'GET show' do
    let(:category) { create :category }
    it 'assign category and products' do
      get :show, id: category.id
      assigns(:category).should be
      assigns(:products).should be
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
        post :create, category: {
          page_attributes: attributes_for(:page)
        }
        flash[:notice].should have_content(/created/i)
      end
    end
    context 'with invalid data' do
      it 'not redirect to index' do
        post :create, category: {
          page_attributes: { title: Faker::Name.title }
        }
        response.should be_success
      end
    end
  end
  describe 'GET edit' do
    let(:category) { create :category }
    it 'assigns not new category' do
      get :edit, id: category.id
      assigns(:category).should_not be_a_new(Category)
    end
  end
  describe 'PUT update' do
    let(:category) { create :category }
    context 'redirect_to' do
      it 'update category and redirect to categories if category is root' do
        put :update, id: category.id, category: { page_attributes: attributes_for(:page) }
        flash[:notice].should have_content(/updated/i)
        response.should redirect_to([:admin, :categories])
        expect { category.reload }.to change { category.page.title }
      end
      let(:subcategory) { create :category, parent: category }
      it 'update category and redirect to categories if category is not root' do
        put :update, id: subcategory.id, category: { page_attributes: attributes_for(:page) }
        response.should redirect_to([:admin, subcategory.parent])
      end
    end
    it 'remove spaces around' do
      put :update,
        id: category.id,
        category: {
          page_attributes: { title: "  #{category.page.title}  ", url: Faker::Lorem.word }
        }
      expect { category.reload }.to_not change { category.page.title }
    end

    let(:parent_category) { create :category }
    it "change parent" do
      put :update,
        id: category.id,
        category: { parent_id: parent_category.id }
      expect { category.reload }.to change { category.parent }
    end
  end
  describe 'POST create_subcategory' do
    let(:category) { create :category }
    it 'create subcategory' do
      post :create_subcategory,
        id: category.id,
        category: { page_attributes: attributes_for(:page) }
      flash[:notice].should have_content(/created/i)
    end
  end
  describe 'POST sort' do
    let(:category) { create :category, children_count: 2 }
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
  describe 'DELETE' do
    it 'destroy Category' do
      category = create :category
      expect {
        xhr :delete, :destroy, id: category.id
        category.reload
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
    it 'flash error if Category has children' do
      category = create :category, children_count: 3
      xhr :delete, :destroy, id: category.id
      flash[:error].should have_content(/forbidden/i)
    end
  end
end