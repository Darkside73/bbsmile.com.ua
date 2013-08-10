require 'spec_helper'

describe Brand do
  context "when search" do
    before { create_list :brand, 3 }
    describe ".by_name" do
      subject { Brand.by_name('test') }
      it { should be_an ActiveRecord::Relation }
    end
  end

  describe "content relation" do
    let(:brand) { create :brand_with_content }
    it 'has content' do
      brand.description.should be
    end
  end
end
