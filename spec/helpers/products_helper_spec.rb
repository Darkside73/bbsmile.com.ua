require 'rails_helper'

describe ProductsHelper do
  describe "#variant_image_url" do
    context "variant with image" do
      let(:variant) { create :variant_with_image }
      subject { helper.variant_image_url(variant, :grid) }
      it "return variant image url" do
        assign :product, variant.product
        should == variant.image.url(:grid)
      end
    end
    context "variant without image" do
      let(:variant) { create :variant }
      subject { helper.variant_image_url(variant, :grid) }
      it { should == 'no_image.png' }
    end
    context "master variant without image" do
      let(:variant) { create :master_variant_without_image }
      subject { helper.variant_image_url(variant, :grid) }
      it "returns product first image" do
        assign :product, variant.product
        should == variant.product.images.first.url(:grid)
      end
    end
    context "master variant without image and product image" do
      let(:variant) { create :variant }
      before { variant.master = true }
      before { assign :product, variant.product }
      subject { helper.variant_image_url(variant, :grid) }
      it { should == 'no_image.png' }
    end
  end
end
