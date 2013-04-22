FactoryGirl.define do
  sequence(:sku) { |n| Faker::Lorem.word + n.to_s }

  factory :product do
    ignore do
      page_title false
    end

    page {
      page_attrs = {}
      page_attrs[:title] = page_title if page_title
      build(:page, page_attrs)
    }
    price 1.5
    available false
    sku { generate :sku }
  end
end
