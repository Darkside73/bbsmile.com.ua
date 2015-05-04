FactoryGirl.define do
  sequence(:url) { |n| Faker::Lorem.word + n.to_s }
  sequence(:title) { |n| Faker::Name.title }

  factory :page do
    url { generate :url }
    title { generate :title }

    factory :hidden_page do
      hidden true
    end

    factory :page_with_related_pages do
      related_pages { create_list :related_page, 2, type_of: :similar }
    end
  end
end
