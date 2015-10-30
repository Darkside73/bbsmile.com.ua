FactoryGirl.define do
  factory :offer do
    association :product, factory: :product_with_variants
    association :product_offer, factory: :product_with_variants
    price 50
  end
end
