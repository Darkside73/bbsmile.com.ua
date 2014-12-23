require 'rails_helper'

describe ProductsController do
  describe "#gallery_for" do
    context 'product with images' do
      let(:product) { create :product_with_images }
      it 'render gallery' do
        expect receive(:render_to_body)
        subject.gallery_for(product)
      end
    end

    context 'product without images' do
      let(:product) { create :product }
      it 'return empty string' do
        expect(subject.gallery_for product).to be_blank
      end
    end
  end
end
