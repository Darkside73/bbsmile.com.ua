FactoryGirl.define do
  sequence(:random_url) { Faker::Lorem.word }

  factory :page

  factory :category do
    ignore do
      subcategories []
    end
    url { generate(:random_url) }
    after(:create) do |category, evaluator|
      evaluator.subcategories.each do |subcategory|
        create(:subcategory, title: subcategory, parent: category)
      end
    end
  end

  factory :subcategory, class: Category do
    url { generate(:random_url) }
  end
end
