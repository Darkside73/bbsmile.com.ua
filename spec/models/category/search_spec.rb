require 'spec_helper'

describe Category do
  describe "#products_grid" do
    context "sorting" do
      let(:category) { category = create :category_with_products }
      it "sort by variant price descending" do
        products = category.products_grid(sort: :price, direction: 'desc')
        products.first.price.should be > products.second.price
      end
    end
    context "searching" do
      let(:category) { category = create :category_with_products }
      it "search by tags" do
        tag = category.products.collect(&:tag_list).flatten.sample
        products = category.products_grid(tags: [tag])
        products.sample.tag_list.should include(tag)
      end
    end
  end
end
