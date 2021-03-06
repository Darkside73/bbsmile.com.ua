FactoryGirl.define do

  factory :product do

    category
    brand
    pageable

    factory :product_with_single_variant do
      variants { |variants| [variants.association(:variant)] }
    end
    factory :product_with_variants do
      variants { create_list :variant_with_image, 3 }
    end
    factory :unavailable_product do
      variants { create_list :variant, 2, available: false }
    end
    factory :product_with_content do
      association :content
    end
    factory :product_with_images do
      images { |images| [images.association(:product_image)] }
    end
    factory :tagged_product do
      tag_list 'tag1, tag2'
      variants { create_list :variant, 3 }
    end
    factory :hidden_product do
      page { create :hidden_page }
    end
    factory :drop_price_product, parent: :product_with_variants do
      drop_price true
    end
  end
end
