require 'spec_helper'

describe 'Category factory' do
  it 'create category' do
    category = create :category, page_title: 'test'
    category.page.should be_an(Page)
    category.page.should_not be_a_new(Page)
    category.page.title.should == 'test'
  end

  it 'create categories list' do
    create_list :category, 3
  end

  it 'create subcategories with page title' do
    category = create :category, subcategories: %w(test1 test2)
    category.children.first.page.title.should == 'test1'
  end
end
