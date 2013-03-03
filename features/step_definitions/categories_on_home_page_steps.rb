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

Then(/^I should see at first position category "(.*?)"$/) do |category|
  find('#catalog-items .item:first-child h3').should have_content(category)
end

Then(/^I should see at first position subcategory "(.*?)"$/) do |subcategory|
  subcategories = find_link(subcategory).first(:xpath, '..').first(:xpath, '..')
  subcategories.find('h4:first-child').text.should == subcategory
end