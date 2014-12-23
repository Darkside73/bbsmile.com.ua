require 'rails_helper'

describe Page do
  context 'when save page' do
    it 'create page from factory' do
      expect(create :page).to be_an(Page)
    end
    it 'create page from factory with custom title' do
      expect(create :page, title: 'Page!').to be_an(Page)
    end
    it 'not allow url duplication' do
      page = create :page, url: 'duplication'
      expect(subject).to_not allow_value('duplication').for(:url)
    end
    it 'normalize default attributes on save' do
      page = build :page
      page.title = '    title with spaces    '
      page.save
      expect { page.reload }.not_to change { page.title }
    end
    it 'normalize url* attributes with strip slashes on save' do
      page = build :page
      page.url = '/url/with/leading/slashes/'
      page.url_old = '/url/with/leading/slash'
      page.save
      expect(page.url).to eq('url/with/leading/slashes')
      expect(page.url_old).to eq('url/with/leading/slash')
    end
    it "set title to name unless name" do
      page = build :page, title: 'pretty page', name: nil
      page.save
      expect(page.name).to eq(page.title)
    end
    it "nilify url_old if it blank" do
      page = build :page
      page.url_old = ''
      page.save
      expect(page.url_old).to be_nil
    end
  end
end
