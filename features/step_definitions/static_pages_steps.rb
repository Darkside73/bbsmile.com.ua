# encoding : utf-8
Given /^Some published pages$/ do
  create :page, title: 'Доставка'
  create :page, title: 'Оплата'
  create :page, title: 'Гарантии'
end

Then /^I should see "(.+)" in (\d+|\w+)$/ do |text, tag|
  find(tag).native.text.should have_content(text)
end

Then /^I should see link "(.+)" in page content$/ do |text|
  find_link(text).should be
end