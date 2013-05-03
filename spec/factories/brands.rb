FactoryGirl.define do
  sequence(:name) { |n| Faker::Lorem.word + n.to_s }

  factory :brand do
    name { generate :name }
  end
end
