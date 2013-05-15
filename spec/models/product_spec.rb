require 'spec_helper'

describe Product do
  let(:category) { create :category }
  context 'when save' do
    it 'create record with page' do
      expect {
        Product.create(
          price: 20.5, category_id: category.id,
          page_attributes: { title: 'Some product', url: 'some/url' }
        )
      }.to change { Product.count }.by(1)
    end
  end

  context "content relation" do
    let(:product) { create :product_with_content }
    it 'has content' do
      product.content.text.should be
    end
  end

  context "images relation" do
    let(:product) { create :product_with_images }
    it 'has attached image' do
      image = product.images.first
      image.asset.url.should be
    end
  end
end
