require 'rails_helper'

describe 'Admin categories' do
  let(:categories) { create_list :category, 3 }
  context 'sort' do
    it 'routable' do
      expect(post: sort_admin_category_path(categories.first)).to be_routable
    end
  end
end

describe 'Articles' do
  let(:article) { create :article }
  it 'route to article controller' do
    expect(get: "/articles/#{article.url}").to route_to(
      controller: "articles",
      action: "show",
      slug: article.url
    )
  end
end

describe 'Pages and specific items' do
  let(:page) { create :page }
  it 'route to pages controller if page requested' do
    expect(get: "/#{page.url}").to route_to(
      controller: "pages",
      action: "show",
      slug: page.url
    )
  end
  let(:category) { create :category }
  it 'route to categories controller if category requested' do
    expect(get: "/#{category.url}").to route_to(
      controller: "categories",
      action: "show",
      slug: category.url
    )
  end
  let(:product) { create :product }
  it 'route to products controller if product requested' do
    expect(get: "/#{product.url}").to route_to(
      controller: "products",
      action: "show",
      slug: product.url
    )
  end
end
