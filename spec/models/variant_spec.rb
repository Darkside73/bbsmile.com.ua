require 'spec_helper'

describe Variant do
  describe "images relation" do
    let(:variant) { create :variant_with_image }
    it 'has attached image' do
      variant.image.should be_a_kind_of(Variant::Image)
      variant.image.url.should be
    end
    it 'delete image if delete_image is on' do
      variant.delete_image = true
      variant.save
      variant.image.should be_nil
    end
    it 'not delete image if delete_image is off' do
      variant.delete_image = false
      variant.save
      variant.image.should be
    end
  end

  describe "instance methods" do
    let(:variant) { create :variant }
    subject { variant }
    its(:title) { variant.title.should include(variant.product.title, variant.name, variant.sku) }
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
end
