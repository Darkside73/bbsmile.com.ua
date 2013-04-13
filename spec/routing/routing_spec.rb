require 'spec_helper'

describe 'Admin categories' do
  let(:categories) { create_list :category, 3 }
  context 'sort' do
    it 'routable' do
      { post: sort_admin_category_path(categories.first) }.should be_routable
    end
  end
end

describe 'Pages and categories' do
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
end