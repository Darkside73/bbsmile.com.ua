require 'spec_helper'

describe 'Admin categories' do
  let(:categories) { create_list :category, 3 }
  context 'sort' do
    it 'routable' do
      { post: sort_admin_category_path(categories.first) }.should be_routable
    end
  end
end

describe 'Articles' do
  let(:article) { create :article }
  it 'route to article controller' do
    { get: "/articles/#{article.url}" }.should route_to(
      controller: "articles",
      action: "show",
      slug: article.url
    )
  end
end

describe 'Pages and specific items' do
  let(:page) { create :page }
  it 'route to pages controller if page requested' do
    { get: "/#{page.url}" }.should route_to(
      controller: "pages",
      action: "show",
      slug: page.url
    )
  end
  let(:category) { create :category }
  it 'route to categories controller if category requested' do
    { get: "/#{category.url}" }.should route_to(
      controller: "categories",
      action: "show",
      slug: category.url
    )
  end
  let(:product) { create :product }
  it 'route to products controller if product requested' do
    { get: "/#{product.url}" }.should route_to(
      controller: "products",
      action: "show",
      slug: product.url
    )
  end
end
