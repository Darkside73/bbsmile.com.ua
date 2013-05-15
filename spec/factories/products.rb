FactoryGirl.define do
  sequence(:sku) { |n| Faker::Lorem.word + n.to_s }
  sequence(:price) { |n| Random.new.rand(0.0..n*100).round(2) }

  factory :product do
    ignore do
      page_title false
    end

    category
    brand

    # TODO DRY pageable factories
    page {
      page_attrs = {}
      page_attrs[:title] = page_title if page_title
      build(:page, page_attrs)
    }
    price { generate :price }
    available false
    sku { generate :sku }

    factory :product_with_content do
      association :content
    end
    factory :product_with_images do
      images { |images| [images.association(:image)] }
    end
    factory :tagged_product do
      tag_list 'tag1, tag2'
    end
  end
end
