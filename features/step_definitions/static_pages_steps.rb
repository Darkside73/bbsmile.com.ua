# encoding : utf-8
Given /^Some published pages$/ do
  create :page, title: 'Доставка', url: 'shipping'
  create :page, title: 'Оплата', url: 'payment'
  create :page, title: 'Гарантии', url: 'warranty'
end

Then /^I should see "(.+)" in (\d+|\w+)$/ do |text, tag|
  find(tag).native.text.should have_content(text)
end

Then /^I should see link "(.+)" in page content$/ do |text|
  find_by_id('page-content').find_link text
end