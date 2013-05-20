require 'spec_helper'

describe Product do
  context "instance methods" do
    describe "#description" do
      it "return text from content" do
        product = create :product_with_content
        product.description.should == product.content.text
      end
      it "return nil if no content" do
        product = create :product
        product.description.should be_nil
      end
    end
  end

  describe 'when save' do
    let(:category) { create :category }
    it 'create record with page and master price variant' do
      expect {
        product = Product.create(
          category_id: category.id,
          page_attributes: { title: 'Some product', url: 'some/url' },
          variants_attributes: [{ price: 20 }]
        )
        product.master_variant.should be
        product.master_variant.master.should be_true
      }.to change { Product.count }.by(1)
    end
    # it "not create variant if variant price is blank"
  end

  describe "variants relation" do
    let(:product) { create :product_with_variants }
    let(:master_variant) { product.master_variant }
    it "delegate variant related methods to master variant" do
      product.price.should == master_variant.price
      product.available.should == master_variant.available
      product.sku.should == master_variant.sku
    end
  end

  describe "content relation" do
    let(:product) { create :product_with_content }
    it 'has content' do
      product.content.text.should be
    end
  end

  describe "images relation" do
    let(:product) { create :product_with_images }
    it 'has attached image' do
      image = product.images.first
      image.asset.url.should be
    end
  end
end
