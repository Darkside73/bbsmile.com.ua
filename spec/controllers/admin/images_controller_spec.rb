require 'spec_helper'

describe Admin::ImagesController do
  describe 'POST create' do
    let(:product) { create :product}
    before { Image.any_instance.stub(:save_attached_files) }
    it 'create image' do
      file = fixture_file_upload(Rails.root.join('spec/fixtures/files/product_image.jpg'), 'image/jpeg')
      post :create, product_id: product.id, image: { asset: file }
      flash[:notice].should have_content(/uploaded/i)
      should redirect_to([:admin, product])
    end
  end
  describe 'DELETE' do
    it 'destroy Image' do
      image = create :image
      expect {
        xhr :delete, :destroy, id: image.id
        image.reload
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
