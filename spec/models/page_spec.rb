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
      page.url.should == 'url/with/leading/slashes'
      page.url_old.should == 'url/with/leading/slash'
    end
    it "set title to name unless name" do
      page = build :page, title: 'pretty page', name: nil
      page.save
      page.name.should == page.title
    end
    it "nilify url_old if it blank" do
      page = build :page
      page.url_old = ''
      page.save
      page.url_old.should be_nil
    end
  end
end
