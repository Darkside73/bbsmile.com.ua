FactoryGirl.define do
  factory :category do
    ignore do
      subcategories []
      children_count false
    end

    pageable

    after(:create) do |category, evaluator|
      if evaluator.children_count
        create_list :category, evaluator.children_count, parent: category
      else
        evaluator.subcategories.each do |page_title|
          create(:category, page_title: page_title, parent: category)
        end
      end
    end

    factory :leaf_category do
      leaf true
    end

    factory :hidden_category do
      page { create(:page, hidden: true) }
    end

    factory :category_with_products do
      products {
        create_list(:product_with_variants, 3) + create_list(:tagged_product, 3)
      }
    end

    factory :category_with_price_ranges do
      price_ranges { create_list :price_range, 3 }
    end

    factory :category_with_content do
      association :content
    end
  end
end
