Given(/^Category with products$/) do
  @category = create :leaf_category
  @products = create_list :product_with_variants, 3, category: @category
end

When(/^I open this category page$/) do
  visit "/#{@category.url}"
end

Then(/^I should see products with prices$/) do
  expect(all '.product').to have(3).things
  @products.collect(&:price).each do |price|
    page.should have_content(number_to_currency price)
  end
end
