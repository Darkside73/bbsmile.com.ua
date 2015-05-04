require 'rails_helper'

describe RelatedPage do
  let(:related_page) { create :related_page }
  it "has relations" do
    expect(related_page.page).to be_a(Page)
    expect(related_page.related).to be_a(Page)
  end

  let(:page) { create :page }
  let(:similar_page) { create :page}
  it 'create relation between pages' do
    related = page.related_pages.build(
      related: similar_page,
      type_of: :similar
    )
    expect { related.save }.to change { page.similar_pages.count }.by(1)
  end

  context 'validation' do
    it { should validate_presence_of :page }
    it { should validate_presence_of :related }
  end
end
