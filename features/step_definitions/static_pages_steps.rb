# encoding : utf-8
Given /^Some published pages$/ do
  create :page, title: 'Информация', url: 'information'
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

When /^I am go to non\-existen page$/ do
  visit '/' + (0...10).map{ ('a'..'z').to_a[rand(26)] }.join
end

Then /^I should get http status code (\d+)$/ do |code|
  response.response_code.should eq(code)
end