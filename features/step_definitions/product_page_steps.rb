When(/^I open this product page$/) do
  visit "/#{@product.url}"
end

Then(/^I should see variants$/) do
  @product.variants.each do |v|
    page.should have_content(v.name, v.price)
  end
end

Given(/^Product with single variant$/) do
  @product = create :product_with_single_variant
end