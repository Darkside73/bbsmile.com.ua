Given(/^Some categories and subcategories$/) do
  @categories = []
  3.times do
    @categories << create(:category, children_count: 2)
  end
end

Then(/^I should see root categories list$/) do
  actual_categories = all('.categories-list a.name').collect(&:text)
  expect(actual_categories).to match_array(@categories.collect &:title)
end

When(/^I click on category link$/) do
  @category = @categories.first
  click_link @category.title
end

Then(/^I should see it subcategories list$/) do
  actual_categories = all('.categories-list a.name').collect(&:text)
  expect(actual_categories).to match_array(@category.children.collect &:title)
end

When(/^I click on new category link$/) do
  find('a#new-category').click
end

When(/^I click on category edit link$/) do
  @category = @categories.first
  find("a[href='#{edit_admin_category_path(@category)}']").click
end

When(/^I go to subcategory edit$/) do
  @subcategory = @categories.first.children.first
  visit url_for [:edit, :admin, @subcategory]
end

Given(/^I am viewing some category page$/) do
  @some_category = @categories.second
  visit url_for [:admin, @some_category]
end

When(/^return to parent category page$/) do
  visit admin_category_path(@some_category)
end

Given(/^I am editing some category page$/) do
  @some_category = @categories.first
  visit url_for [:edit, :admin, @some_category]
end

Given(/^I am editing some subcategory page$/) do
  @some_subcategory = @categories.first.children.second
  visit url_for [:edit, :admin, @some_subcategory]
end

Then(/^Subcategory should be a leaf$/) do
  expect { @some_subcategory.reload }.to change { @some_subcategory.leaf }.from(false).to(true)
end

Given(/^I am viewing some leaf category$/) do
  leaf_category = @categories.first.children.second
  leaf_category.leaf = true
  leaf_category.save
  visit url_for [:admin, leaf_category]
end

Then(/^I should( not)? see hidden category$/) do |negation|
  page.send("should#{'_not' if negation}", have_content(@some_category.title))
end

Then(/^Subcategories should be hidden$/) do
  @some_category.children.each do |child|
    expect(child.page.hidden).to be_truthy
  end
end

Given(/^Destination parent category "(.*?)"$/) do |title|
  @destination_category = create(:category, page_title: title)
end
