Given(/^Leaf category "(.*?)"$/) do |category|
  @category = create :category, leaf: true, page_title: category
end

Given(/^I go to this category$/) do
  visit url_for([:admin, @category])
end

Then(/^This product "(.*?)" should belongs to current category$/) do |product_title|
  product = Page.find_by!(title: product_title).pageable
  product.category.should == @category
end

Given(/^Some products in category$/) do
  @products = create_list :product, 3, category_id: @category.id
end

Then(/^I should see this products$/) do
  all('.product-list a.name').collect(&:text).should =~ @products.collect(&:title)
end

Given(/^Some product$/) do
  @product = create :product
end

When(/^I go to this product edit$/) do
  visit url_for([:edit, :admin, @product])
end

When(/^I go to this product$/) do
  visit url_for([:admin, @product])
end

Then(/^I should see product properties$/) do
  [@product.title, @product.price, @product.category.title].each do |attribute|
    page.should have_content(attribute)
  end
end

When(/attach the file "(.*?)" to "(.*?)"$/) do |file, field|
  attach_file field, File.expand_path("features/fixtures/#{file}")
end

Then(/^file should be uploaded$/) do
  pending
  File.open
end
