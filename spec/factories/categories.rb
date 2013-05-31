FactoryGirl.define do
  factory :category do
    ignore do
      subcategories []
      children_count false
      page_title false
    end

    page {
      page_attrs = {}
      page_attrs[:title] = page_title if page_title
      build(:page, page_attrs)
    }

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

    factory :category_with_products do
      products { create_list :product_with_variants, 3 }
    end
  end
end
