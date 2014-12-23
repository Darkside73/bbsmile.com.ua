require 'rails_helper'

describe Product do
  context "instance methods" do
    describe "#description" do
      it "return text from content" do
        product = create :product_with_content
        expect(product.description).to eq(product.content.text)
      end
      it "return nil if no content" do
        product = create :product
        expect(product.description).to be_nil
      end
    end
    describe "#age=" do
      let(:product) { create :product }
      context "when from and to are present" do
        it "assigns both values" do
          product.age = '0.5-2'
          expect(product.age_from).to eq(0.5)
          expect(product.age_to).to eq(2)
        end
      end
      context "when one value given" do
        it "assigns value" do
          product.age = '1'
          expect(product.age_from).to eq(1)
          expect(product.age_to).to eq(1)
        end
      end
      context "when to given" do
        it "assigns 0 to from" do
          product.age = '-1'
          expect(product.age_from).to eq(0)
        end
      end
      context "when from given" do
        it "assigns 16 to to" do
          product.age = '3-'
          expect(product.age_to).to eq(16)
        end
      end
      context "when empty string given" do
        it "assigns nil" do
          product.age = ''
          expect(product.age_from).to be_nil
          expect(product.age_to).to be_nil
        end
      end
    end

    describe '#sex' do
      subject { create :product, sex: :for_girls }
      it { should respond_to(:for_girls?) }
      it "show previous value" do
        subject.sex = 'for_boys'
        expect(subject.sex_was).to eq('for_girls')
      end
      context 'when not valid' do
        it "raise error" do
          expect { build(:product, sex: :ufo) }.to raise_error(ArgumentError)
        end
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
        expect(product.master_variant).to be
        expect(product.master_variant.master).to be_truthy
      }.to change { Product.count }.by(1)
    end
    let(:video) { 'http://youtube.com/watch?v=code&other=params' }
    it "convert youtube watch link to embed link" do
      product = build :product, video: video
      product.save
      expect(product.video).to eq('http://youtube.com/embed/code')
    end
  end

  describe "variants relation" do
    let(:product) { create :product_with_variants }
    let(:master_variant) { product.master_variant }
    it "delegate variant related methods to master variant" do
      expect(product.price).to eq(master_variant.price)
      expect(product.available).to eq(master_variant.available)
      expect(product.sku).to eq(master_variant.sku)
    end
  end

  describe "content relation" do
    let(:product) { create :product_with_content }
    it 'has content' do
      expect(product.content.text).to be
    end
  end

  describe "images relation" do
    let(:product) { create :product_with_images }
    it 'has attached image' do
      image = product.images.first
      expect(image).to be_a_kind_of(Product::Image)
      expect(image.url).to be
    end
  end

  describe 'related products' do
    let(:product) { create :product_with_related_products }
    context 'association to RelatedProduct' do
      subject { product.related_products }
      it "has related products" do
        should have_at_least(1).items
        subject.each do |related|
          expect(related).to be_a(RelatedProduct)
        end
      end
    end
    context 'association to products through related products' do
      subject { product.similar_products }
      it "has similar products" do
        should have_at_least(1).items
        subject.each do |related|
          expect(related).to be_a(Product)
        end
      end
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
      should be_falsey
    end
  end

  describe "#in_range?" do
    let!(:product) { create(:product_with_variants) }
    it "checks product price for matching price range" do
      price_range = create :price_range, from: product.price - 10
      expect(product.in_range? price_range).to be_truthy
    end
  end

  context "when search" do
    describe ".by_title" do
      before do
        create_list :product, 3
        @matched = create :product, page_title: 'test'
      end
      subject { Product.visible.by_title('test') }
      it { should be_an ActiveRecord::Relation }
      it "include matched page" do
        should include(@matched)
      end
    end

    context 'by sex' do
      let!(:product_for_girls) { create :product, sex: :for_girls }
      let!(:product_for_boys) { create :product, sex: :for_boys }
      let!(:product_for_any_gender) { create :product, sex: :for_any_gender }
      describe ".for_girls" do
        subject { Product.for_girls }
        it "result include product for girls" do
          should include(product_for_girls)
          should include(product_for_any_gender)
        end
        it "result not include product for boys" do
          should_not include(product_for_boys)
        end
      end
    end
  end
end
