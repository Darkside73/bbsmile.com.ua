# encoding : utf-8
Given /^Some published pages$/ do
  create :page, title: 'Доставка', url: 'shipping'
  create :page, title: 'Оплата', url: 'payment'
  create :page, title: 'Гарантии', url: 'warranty'
end

Then /^I should see "(.+)" in (\d+|\w+) tag$/ do |text, tag|
  find(tag).text.should have_content(text)
end

Then(/^I should see "(.*?)" in page title$/) do |title|
  page.title.should have_content(title)
end

Then /^I should see link "(.+)" in page content$/ do |text|
  find_by_id('page-content').find_link text
end

Given(/^Hidden page$/) do
  @hidden_page = create :page, hidden: true
end

Then(/^Hidden page should be inaccessible$/) do
  expect { visit "/#{@hidden_page.url}" }.to raise_error
end