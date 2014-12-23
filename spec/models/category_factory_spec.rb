require 'rails_helper'

describe 'Category factory' do
  it 'create category' do
    category = create :category, page_title: 'test'
    expect(category.page).to be_an(Page)
    expect(category.page.title).to eq('test')
  end

  it 'create categories list' do
    create_list :category, 3
  end

  it 'create subcategories with page title' do
    category = create :category, subcategories: %w(test1 test2)
    expect(category.children.first.page.title).to eq('test1')
  end
end
