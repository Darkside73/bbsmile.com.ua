FactoryGirl.define do
  sequence(:price_int) { |n| n * 100 }

  factory :price_range do
    from { generate :price_int }
    to { from + 1000 }
    category
  end
end
