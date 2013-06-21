FactoryGirl.define do
  sequence(:url) { |n| Faker::Lorem.word + n.to_s }
  sequence(:title) { |n| Faker::Name.title }

  factory :page do
    url { generate :url }
    title { generate :title }

    factory :product_page do
      pageable_type 'Product'
    end

    factory :hidden_page do
      hidden true
    end
  end
end
