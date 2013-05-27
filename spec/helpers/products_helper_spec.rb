require 'spec_helper'

describe ProductsHelper do
  describe "#variant_image_url" do
    context "variant with image" do
      let(:variant) { create :variant_with_image }
      subject { helper.variant_image_url(variant, :thumb) }
      it "return variant image url" do
        should == variant.image.url(:thumb)
      end
    end
    context "variant without image" do
      let(:variant) { create :variant }
      subject { helper.variant_image_url(variant, :thumb) }
      it { should be_nil }
    end
    context "master variant without image" do
      let(:variant) { create :master_variant_without_image }
      subject { helper.variant_image_url(variant, :thumb) }
      it "returns product first image" do
        should == variant.product.images.first.url(:thumb)
      end
    end
    context "master variant without image and product image" do
      let(:variant) { create :variant }
      before { variant.master = true }
      subject { helper.variant_image_url(variant, :thumb) }
      it { should be_nil }
    end
  end
end