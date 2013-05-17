require 'spec_helper'

describe Variant do
  context "images relation" do
    let(:variant) { create :variant_with_image }
    it 'has attached image' do
      variant.image.asset.url.should be
    end
    it 'delete image by setting delete_image to true' do
      variant.delete_image = true
      variant.save
      variant.image.should be_nil
    end
  end
end
