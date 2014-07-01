require 'rails_helper'

describe Category do
  describe "#products_grid" do
    context "sorting" do
      let(:category) { category = create :category_with_products }
      it "sort by variant price descending" do
        products = category.products_grid(sort: :price, direction: 'desc')
        first_product_price  = products.first.variants.collect(&:price).max
        second_product_price = products.second.variants.collect(&:price).max
        first_product_price.should be >= second_product_price
      end
    end
    context "searching" do
      let(:category) { category = create :category_with_products }
      it "search by tags" do
        tag = category.tags.sample
        products = category.products_grid(tags: [tag])
        products.sample.tag_list.should include(tag)
      end
      it "search by brands" do
        brand = category.brands.sample
        products = category.products_grid(brands: [brand.name])
        products.sample.brand.should == brand
      end
    end
  end
end
