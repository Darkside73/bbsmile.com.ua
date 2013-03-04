Given /^Product category "(.*?)" and subcategory "(.*?)"$/ do |category, subcategory|
  create :category, title: category, subcategories: [subcategory]
end

Then /^I should see link "(.*?)" as category$/ do |text|
  find_by_id('catalog-items').find_link text
end

Then /^I should see link "(.*?)" as it subcategory$/ do |text|
  find_by_id('catalog-items').find_link text
end

Given(/^Product category "(.*?)" and subcategories "(.*?)", "(.*?)", "(.*?)"$/) do |category, *subcategories|
  create :category, title: category, subcategories: subcategories
end

Given(/^Following positions$/) do |table|
  table.rows_hash.each do |category, position|
    Category.find_by_title!(category).update_attributes(position: position)
  end
end

Then(/^I should see categories in this order$/) do |table|
  expected_order = table.raw.flatten
  actual_order = all('.item h3').collect(&:text)
  expected_order.should == actual_order
end

Then(/^I should see subcategories from "(.*?)" in this order$/) do |category, table|
  expected_order = table.raw.flatten
  category_url = Category.find_by_title!(category).url
  actual_order = find("h3 a[href$=#{category_url}]").first(:xpath, '..').first(:xpath, '..').all('h4').collect(&:text)
  expected_order.should == actual_order
end