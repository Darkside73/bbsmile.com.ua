Given(/^Some categories and subcategories$/) do
  @categories = []
  3.times do
    @categories << create(:category, title: Faker::Name.title, subcategories: [Faker::Name.title, Faker::Name.title])
  end
end

Then(/^I shoud see root categories list$/) do
  all('.categories-list a').collect(&:text).should =~ @categories.collect(&:title)
end

When(/^I click on category link$/) do
  @category = @categories.first
  click_link @category.title
end

Then(/^I shoud see it subcategories list$/) do
  all('.subcategories-list a').collect(&:text).should =~ @category.children.collect(&:title)
end

When(/^I click on new category link$/) do
  find('a#new-category').click
end

When(/^press button "(.*?)"$/) do |text|
  click_button text
end

Then(/^I shoud see category "(.*?)" in categories list$/) do |category_title|
  page.should have_content(category_title)
end

Given(/^I am viewing some category page$/) do
  # visit admin_category_path
  pending
end

When(/^fill in category title field with "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then(/^I shoud see category with title "(.*?)" in categories list$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

When(/^I click on add new subcategory link$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^fill in title field and url field$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^select parent category$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I shoud see created subcategory in subcategories list$/) do
  pending # express the regexp above with the code you wish you had
end