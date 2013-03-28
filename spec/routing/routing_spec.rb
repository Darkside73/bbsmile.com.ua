require 'spec_helper'

describe 'Admin categories routing' do
  before :all do
    @categories = create_list :category, 3
  end
  context 'sort' do
    it 'routable' do
      { post: sort_admin_category_path(@categories.first) }.should be_routable
    end
  end
end