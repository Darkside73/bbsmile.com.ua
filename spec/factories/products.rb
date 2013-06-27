FactoryGirl.define do

  factory :product do
    ignore do
      page_title false
      page_url_old false
    end

    category
    brand

    # TODO DRY pageable factories
    page {
      page_attrs = {}
      page_attrs[:title] = page_title if page_title
      page_attrs[:url_old] = page_url_old if page_url_old
      build(:page, page_attrs)
    }

    factory :product_with_single_variant do
      variants { |variants| [variants.association(:variant)] }
    end
    factory :product_with_variants do
      variants { create_list :variant, 3 }
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
  end
end
