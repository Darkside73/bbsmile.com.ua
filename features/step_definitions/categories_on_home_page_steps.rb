Given /^Product category "(.*?)" and subcategory "(.*?)"$/ do |category, subcategory|
  category = create :category, title: category, subcategory: subcategory
  # pp category.arrange
end

Then /^I should see link "(.*?)" as category$/ do |text|
  find_by_id('catalog-items').find_link text
end

Then /^I should see link "(.*?)" as it subcategory$/ do |text|
  find_by_id('catalog-items').find_link text
end