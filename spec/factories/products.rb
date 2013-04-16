# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product do
    price 1.5
    available false
    sku "MyString"
  end
end
