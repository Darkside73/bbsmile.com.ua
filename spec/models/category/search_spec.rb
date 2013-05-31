require 'spec_helper'

describe Category do
  describe "#products_grid" do
    let(:category) { category = create :category_with_products }
    it "sort by variant price descending" do
      products = category.products_grid(sort: :price, direction: 'desc')
      products.first.price.should be > products.second.price
    end
  end
end
