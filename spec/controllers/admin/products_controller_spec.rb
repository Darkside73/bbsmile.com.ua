require 'rails_helper'

describe Admin::ProductsController do
  describe 'GET index' do
    let(:products) { create_list :products, 3 }
    it 'assings products' do
      get :index
      expect(assigns :products).to be
    end
  end
  describe 'GET show' do
    let(:product) { create :product }
    it 'product' do
      get :show, id: product
      expect(assigns :product).to be
    end
  end
  describe 'GET new' do
    it 'assigns new product and leaf categories' do
      get :new
      expect(assigns :product).to be_a_new(Product)
      expect(assigns :leaf_categories).to be_a(Array)
    end
  end
  describe 'POST create' do
    let(:category) { create :category}
    before { allow_any_instance_of(Product::Image).to receive(:save_attached_files) }
    it 'create product and redirect to category' do
      file = fixture_file_upload(Rails.root.join('spec/fixtures/files/product_image.jpg'), 'image/jpeg')
      post :create, product: {
        category_id: category.id,
        page_attributes: attributes_for(:page),
        images_attributes: [{ attachment: file }],
        variants_attributes: [{ price: 20, sku: 'code123', available: true }]
      }
      expect(flash[:notice]).to have_content(/created/i)
      expect redirect_to([:admin, Product.last])
    end
  end
  describe 'GET edit' do
    let(:product) { create :product }
    it 'assigns product and category' do
      get :edit, id: product.id
      expect(assigns :product).to be_a(Product)
      expect(assigns :category).to be_a(Category)
    end
  end
  describe 'PUT update' do
    let(:product) { create :product_with_single_variant }
    it 'update product and redirect to show' do
      put :update,
        id: product.id,
        product: {
          page_attributes: attributes_for(:page),
          variants_attributes: [{ id: product.master_variant.id, price: 13.99 }]
        }
      expect(flash[:notice]).to have_content(/updated/i)
      expect redirect_to([:admin, product])
      expect { product.reload }.to change { product.master_variant.price }
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
  describe 'GET tags' do
    it 'success' do
      xhr :get, :tags, format: :json
      expect be_success
    end
  end
  describe 'POST bulk_move' do
    let(:category) { create :category }
    let(:products) { create_list :product, 3 }
    it "move several products to specified category" do
      product1 = products.first
      product2 = products.second
      xhr :post, :bulk_move,
          dest_category_id: category.id,
          ids: [product1.id, product2.id]
      expect { product1.reload }. to change { product1.category }
    end
  end
end
