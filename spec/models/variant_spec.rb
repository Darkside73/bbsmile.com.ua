require 'rails_helper'

describe Variant do
  describe "images relation" do
    let(:variant) { create :variant_with_image }
    it 'has attached image' do
      expect(variant.image).to be_a_kind_of(Variant::Image)
      expect(variant.image.url).to be
    end
    it 'delete image if delete_image is on' do
      variant.delete_image = true
      variant.save
      expect(variant.image).to be_nil
    end
    it 'not delete image if delete_image is off' do
      variant.delete_image = '0'
      variant.save
      expect(variant.image).to be
    end
  end

  describe "instance methods" do
    let(:variant) { create :variant }
    subject { variant }
    its(:title) { expect(variant.title).to include(variant.product.title, variant.name, variant.sku) }
  end

  context "when create new variant" do
    let(:product) { create :product_with_variants }
    it "insert to bottom" do
      last_variant = product.variants.last
      variant = create :variant, name: 'new variant', product: product
      product.variants.reload
      expect(variant.position).to be > last_variant.position
    end
  end

  context "when search" do
    before { create_list :variant, 3 }
    describe ".by_sku" do
      subject { Variant.by_sku('test') }
      it { should be_an ActiveRecord::Relation }
    end
    describe ".visible" do
      before { @hidden_variant = create :hidden_variant }
      subject { Variant.visible }
      it "not include hidden variant" do
        should_not include(@hidden_variant)
      end
    end
  end

  context 'when variant became available' do
    require 'sidekiq/testing'
    let(:variant) { create :variant, available: false }
    it 'create sms and mailer jobs' do
      create :availability_subscriber,
             variant: variant, phone: '123456', email: 'a@b'
      variant.available = true
      expect {
        expect { variant.save }.to(
          change(Sidekiq::Queues["default"], :size).by(1)
        )
      }.to change(Sidekiq::Queues["mailers"], :size).by(1)
      expect(variant.availability_subscribers).to be_empty
    end
  end
end
