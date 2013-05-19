require 'spec_helper'

describe Variant do
  context "images relation" do
    let(:variant) { create :variant_with_image }
    it 'has attached image' do
      variant.image.asset.url.should be
    end
    it 'delete image if delete_image is on' do
      variant.delete_image = true
      variant.save
      variant.image.should be_nil
    end
    it 'not delete image if delete_image is off' do
      ['0', false].each do |val|
        variant.delete_image = val
        variant.save
        variant.image.should be, "fail for #{val}"
      end
    end
  end
end
