require 'rails_helper'

describe Admin::RelatedPagesController do
  describe 'POST create' do
    let(:page) { create :page }
    let(:related) { create :page }
    it 'create relation between pages' do
      expect {
        xhr :post, :create, format: :json,
            page_id: page.id,
            related_page: { related_id: related.id, type_of: :suggested }
        expect be_success
        page.reload
      }.to change { page.suggested_pages.count }.by(1)
    end
  end
  describe 'GET show' do
    let(:related_page) { create :related_page }
    it 'show relation between pages' do
      xhr :get, :show, id: related_page.id, format: :html
      expect be_success
      expect render_template(:show)
    end
  end
  describe 'DELETE' do
    let(:page) { create :page_with_related_pages }
    it 'destroy relation between pages' do
      related = page.related_pages.sample
      expect {
        xhr :delete, :destroy, id: related.id
        expect be_success
        related.reload
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
