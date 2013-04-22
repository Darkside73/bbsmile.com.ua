Given(/^Leaf category "(.*?)"$/) do |category|
  create :category, leaf: true, page_title: category
end