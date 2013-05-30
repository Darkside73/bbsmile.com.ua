require 'spec_helper'

describe ApplicationHelper do
  subject { ApplicationHelper }
  let(:page) { build :page, { name: 'Some page', url: 'url/to' } }
  let(:category) { build :category }
  describe '.link_to' do
    it 'create link from regular args' do
      title = 'some link'
      url = 'http://google.com/'
      link_to(title, url).should include(title, url)
    end
    it 'create link to Page object using name attribute' do
      link_to(page).should include(page.name, "/#{page.url}")
    end
    it 'create link to pageable object' do
      link_to(category).should include(category.name, "/#{category.url}")
    end
    it 'create link to Page object with custom title' do
      custom_title = 'My awesome link'
      link_to(custom_title, page).should include(custom_title, "/#{page.url}")
    end
    it 'create link to Page with CSS class' do
      css_class = 'button'
      link_to(page, class: css_class).should include(css_class)
    end
    it 'raise exception if Page object misplaced' do
      expect { link_to('title', 'url', page) }.to raise_error
    end
  end
end