require 'rails_helper'

describe Admin::ImagesController do
  describe "GET index" do
    let(:product) { create :product }
    it "success" do
      get :index, product_id: product.id
      expect(response).to be_success
      expect(assigns :product).to be
    end
  end
  describe 'DELETE' do
    it 'destroy Image' do
      image = create :product_image
      expect {
        xhr :delete, :destroy, id: image.id
        image.reload
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
  describe 'POST create' do
    let(:product) { create :product }
    before { allow_any_instance_of(Product::Image).to receive(:save_attached_files) }
    it 'create Image' do
      file = fixture_file_upload(Rails.root.join('spec/fixtures/files/product_image.jpg'), 'image/jpeg')
      post :create, product_id: product.id, product_image: { attachment: file }
      expect(flash[:notice]).to have_content(/uploaded/i)
      expect redirect_to([:admin, product, :images])
    end
  end
end
