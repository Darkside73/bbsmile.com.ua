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
      image.should be_a_kind_of(Product::Image)
      image.url.should be
    end
  end

  describe "#top_image" do
    let!(:product) { create(:product_with_images) }
    subject { product.top_image :grid }
    it "return first image url" do
      should == product.images.first.url(:grid)
    end
  end
  describe "#top_image?" do
    let!(:product) { create(:product) }
    subject { product.top_image? }
    it "return false if product without images" do
      should be_false
    end
  end

  describe "#in_range?" do
    let!(:product) { create(:product_with_variants) }
    it "checks product price for matching price range" do
      price_range = create :price_range, from: product.price - 10
      product.in_range?(price_range).should be_true
    end
  end

  context "when search" do
    before do
      create_list :product, 3
      @matched = create :product, page_title: 'test'
    end
    describe "#by_title" do
      subject { Product.visible.by_title('test') }
      it { should be_an ActiveRecord::Relation }
      it "include matched page" do
        should include(@matched)
      end
    end
  end
end
