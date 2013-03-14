Given(/^Some categories and subcategories$/) do
  @categories = []
  3.times do
    @categories << create(:category, title: Faker::Name.title, subcategories: [Faker::Name.title, Faker::Name.title])
  end
end

Then(/^I should see root categories list$/) do
  all('.categories-list a.name').collect(&:text).should =~ @categories.collect(&:title)
end

When(/^I click on category link$/) do
  @category = @categories.first
  click_link @category.title
end

Then(/^I should see it subcategories list$/) do
  all('.subcategories-list a.name').collect(&:text).should =~ @category.children.collect(&:title)
end

When(/^I click on new category link$/) do
  find('a#new-category').click
end

When(/^press button "(.*?)"$/) do |text|
  click_button text
end

When(/^I click on category edit link$/) do
  @category = @categories.first
  find("a[href='#{edit_admin_category_path(@category)}']").click
end

Given(/^I am viewing some category page$/) do
  @some_category = @categories.second
  visit url_for [:admin, @some_category]
end

When(/^return to parent category page$/) do
  visit admin_category_path(@some_category)
end