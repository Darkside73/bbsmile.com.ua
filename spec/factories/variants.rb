FactoryGirl.define do
  sequence(:sku) { |n| Faker::Lorem.word + n.to_s }
  sequence(:price) { |n| Random.new.rand(0.0..n*100).round(2) }

  factory :variant do
    name "color: green"
    price { generate :price }
    sku { generate :sku }
    product

    factory :variant_with_image do
      image
    end
  end
end
