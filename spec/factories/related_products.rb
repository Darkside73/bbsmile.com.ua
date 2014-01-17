FactoryGirl.define do
  factory :related_product do
    product
    association :related, factory: :product
    type_of :similar
  end
end
