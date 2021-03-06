require 'rails_helper'
require 'seo/meta_tags'

describe Seo::MetaTags do
  context "when page has meta description" do
    let(:page) { create :page, meta_description: 'foo' }
    subject { Seo::MetaTags.new page }
    it "use page attribute" do
      expect(subject.description).to eq(page.meta_description)
    end
  end

  context "when page has no meta description" do
    let(:page) { create(:product_with_content).page }
    subject { Seo::MetaTags.new page }
    it "use pagable's specific description" do
      expect(subject.description).to include(page.pageable.description[0..20])
    end
  end

  context "when page is brand" do
    let(:brand) { create(:brand) }
    subject { Seo::MetaTags.new brand }
    it "use brand's attributes" do
      expect(subject.description).to eq(brand.meta_description)
    end
  end
end
