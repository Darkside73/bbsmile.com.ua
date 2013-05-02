require 'spec_helper'

describe Admin::ProductsController do
  describe 'GET index' do
    let(:products) { create_list :products, 3 }
    it 'assings products' do
      get :index
      assigns(:products).should be
    end
  end
  describe 'GET show' do
    let(:product) { create :product }
    it 'product' do
      get :show, id: product
      assigns(:product).should be
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
    before { Image.any_instance.stub(:save_attached_files) }
    it 'create product and redirect to category' do
      file = fixture_file_upload(Rails.root.join('spec/fixtures/files/product_image.jpg'), 'image/jpeg')
      post :create, product: {
        category_id: category.id,
        page_attributes: attributes_for(:page),
        images_attributes: [{ asset: file }]
      }
      flash[:notice].should have_content(/created/i)
      should redirect_to([:admin, category])
    end
  end
  describe 'GET edit' do
    let(:product) { create :product }
    it 'assigns product and category' do
      get :edit, id: product.id
      assigns(:product).should be_a(Product)
      assigns(:category).should be_a(Category)
    end
  end
  describe 'PUT update' do
    let(:product) { create :product }
    it 'update product and redirect to show' do
      put :update,
        id: product.id,
        product: { price: 13.99, page_attributes: attributes_for(:page) }
      flash[:notice].should have_content(/updated/i)
      response.should redirect_to([:admin, product])
      expect { product.reload }.to change { product.price }
    end
  end
  describe 'DELETE' do
    it 'destroy Product' do
      product = create :product
      expect {
        xhr :delete, :destroy, id: product.id
        product.reload
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end