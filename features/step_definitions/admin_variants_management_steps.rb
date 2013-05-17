Then(/^variant should have image$/) do
  all(".thumb img").should have(1).item
end

Given(/^Product with variants$/) do
  @product = create :product_with_variants
end

When(/^I click "(.*?)" for some variant$/) do |link|
  @some_variant = @product.variants.first
  find("##{dom_id(@some_variant)} a.edit").click
end

Given(/^Variant with image$/) do
  @variant = create :variant_with_image
end

When(/^I go to this variant edit$/) do
  visit edit_admin_variant_url(@variant)
end

Then(/^variant should not have image$/) do
  all("##{dom_id(@variant)} .thumb img").should be_empty
end
