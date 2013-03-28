require 'spec_helper'

describe Page do
  context 'when save page' do
    it 'create page from factory' do
      create(:page).should be_an(Page)
    end
    it 'create page from factory with custom title' do
      create(:page, title: 'Page!').should be_an(Page)
    end
    it 'not allow url duplication' do
      page = create :page, url: 'duplication'
      subject.should_not allow_value('duplication').for(:url)
    end
  end
end
