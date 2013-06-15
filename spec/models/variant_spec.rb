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

  describe "#title" do
    let(:variant) { create :variant }
    it "is product title and variant name" do
      variant.title.should == "#{variant.product.title} #{variant.name}"
    end
  end
end
