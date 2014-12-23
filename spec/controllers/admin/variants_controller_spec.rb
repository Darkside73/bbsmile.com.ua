require 'rails_helper'

describe Admin::VariantsController do
  describe 'GET index' do
    let(:product) { create :product }
    it 'assings product' do
      get :index, product_id: product.id
      expect(assigns :product).to be
    end
  end
  describe 'POST create' do
    let(:product) { create :product}
    before { allow_any_instance_of(Variant::Image).to receive(:save_attached_files) }
    it 'create variant and redirect to index' do
      file = fixture_file_upload(Rails.root.join('spec/fixtures/files/product_image.jpg'), 'image/jpeg')
      post :create, product_id: product.id, variant: {
        price: 10.50, sku: 'code123', master: false,
        image_attributes: { attachment: file }
      }
      expect(flash[:notice]).to have_content(/created/i)
      expect redirect_to([:admin, product, :variants])
    end
  end
  describe 'PUT update' do
    let(:variant) { create :variant_with_image }
    it 'update variant and redirect to index' do
      put :update, id: variant.id, variant: { price: 13.99 }
      expect(flash[:notice]).to have_content(/updated/i)
      expect redirect_to(admin_product_variants_url(variant.product))
      expect { variant.reload }.to change { variant.price }
    end
    it 'leave old image if no new image submitted' do
      file = fixture_file_upload(Rails.root.join('spec/fixtures/files/product_image.jpg'), 'image/jpeg')
      put :update, id: variant.id, variant: { image_attributes: { id: variant.image.id } }
      expect(flash[:notice]).to have_content(/updated/i)
      expect redirect_to(admin_product_variants_url(variant.product))
      expect { variant.reload }.to_not change { variant.image }
    end
  end
  describe 'DELETE' do
    let(:variant) { create :variant }
    it 'destroy variant' do
      expect {
        xhr :delete, :destroy, id: variant.id
        variant.reload
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
