Given(/^Some brand$/) do
  @brand = create :brand_with_content
end

When(/^I open this brand page$/) do
  visit brand_page_path(@brand.name)
end

Then(/^I should see brand description$/) do
  page.should have_content(@brand.description)
end
