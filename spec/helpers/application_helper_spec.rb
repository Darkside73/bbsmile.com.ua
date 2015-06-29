require 'rails_helper'

describe ApplicationHelper do
  subject { ApplicationHelper }
  let(:page) { create :page, { name: 'Some page', url: 'url/to' } }
  let(:category) { create :category }
  describe '.link_to' do
    it 'create link from regular args' do
      title = 'some link'
      url = 'http://google.com/'
      expect(link_to title, url).to include(title, url)
    end
    it 'create link to Page object using name attribute' do
      expect(link_to page).to include(page.name, "/#{page.url}")
    end
    it 'create link to pageable object' do
      expect(link_to category).to include(category.name, "/#{category.url}")
    end
    it 'create link to Page object with custom title' do
      custom_title = 'My awesome link'
      expect(link_to custom_title, page).to include(custom_title, "/#{page.url}")
    end
    it 'create link to Page with CSS class' do
      css_class = 'button'
      expect(link_to page, class: css_class).to include(css_class)
    end
    it 'raise exception if Page object misplaced' do
      expect { link_to('title', 'url', page) }.to raise_error ArgumentError
    end
  end
end
