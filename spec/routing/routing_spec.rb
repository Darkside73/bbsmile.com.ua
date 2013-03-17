require 'spec_helper'

describe 'Admin categories routing' do
  before :all do
    @categories = create_list :category, 3, title: Faker::Name.title
  end
  context 'sort' do
    it 'routable only if "position" param given' do
      position = 2
      { post: "/admin/categories/#{@categories.first.id}/sort/#{position}" }.should be_routable
      { post: "/admin/categories/#{@categories.first.id}/sort/-1" }.should_not be_routable
    end
  end
end