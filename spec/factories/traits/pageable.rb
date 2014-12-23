FactoryGirl.define do
  trait :pageable do
    transient do
      page_title false
      page_url { generate :url }
      page_url_old { generate :url }
    end
    page {
      page_attrs = {}
      page_attrs[:title] = page_title if page_title
      page_attrs[:url] = page_url if page_url
      page_attrs[:url_old] = page_url_old if page_url_old
      build(:page, page_attrs)
    }
  end
end
