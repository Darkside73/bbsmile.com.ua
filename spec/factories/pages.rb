FactoryGirl.define do
  sequence(:random_url) { Faker::Lorem.word }

  factory :page

  factory :category do
    ignore do
      subcategory Faker::Name.title
    end
    url { generate(:random_url) }
    after(:create) do |category, evaluator|
      create(:subcategory, title: evaluator.subcategory, parent: category)
    end
  end

  factory :subcategory, class: Category do
    url { generate(:random_url) }
  end
end
