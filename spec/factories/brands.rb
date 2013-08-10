FactoryGirl.define do
  sequence(:name) { |n| Faker::Lorem.word + n.to_s }

  factory :brand do
    name { generate :name }
    factory :brand_with_content do
      association :content
    end
  end
end
