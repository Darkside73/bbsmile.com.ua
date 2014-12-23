Given(/^Some category and subcategories$/) do
  @category = create :category, children_count: 4
  @subcategory = create :category, children_count: 3, parent: @category
end

Given(/^I am visit category page$/) do
  visit "/#{@category.url}"
end

Then(/^I should see subcategories list$/) do
  actual = all('#filterByCategory ul li').collect(&:text)
  expect(actual).to eq(@category.children.collect &:title)
end

When(/^I visit subcategory without own categories page$/) do
  visit "/#{@category.children.second.url}"
end

Then(/^I should see it siblings$/) do
  actual = all('#filterByCategory ul li').collect(&:text)
  expect(actual).to eq(@category.children.second.siblings.collect &:title)
end

Then(/^I should see active current category$/) do
  actual = find('#filterByCategory li.active a').text
  expect(actual).to eq(@category.children.second.title)
end

When(/^I visit subcategory with own categories page$/) do
  visit "/#{@subcategory.url}"
end
