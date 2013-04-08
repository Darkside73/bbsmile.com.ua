Given(/^Some category and subcategories$/) do
  @category = create :category, children_count: 4
  @subcategory = create :category, children_count: 3, parent: @category
end

Given(/^I am visit category page$/) do
  visit "/#{@category.url}"
end

Then(/^I should see subcategories list$/) do
  all('#filterByCategory ul li').collect(&:text).should ==
    @category.children.collect(&:title)
end

When(/^I visit subcategory with own categories page$/) do
  visit "/#{@subcategory.url}"
end

Then(/^I should see it subcategory's siblings$/) do
  all('#filterByCategory ul li').collect(&:text).should ==
    @subcategory.siblings.collect(&:title)
end

Then(/^I should see it subcategories list in #filterBySubcategory$/) do
  all('#filterBySubcategory ul li').collect(&:text).should ==
    @category.children.collect(&:title)
end