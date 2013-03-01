Given /^Some catalog categories$/ do
  create_list :category, 3, title: Faker::Name.title
end

Then /^I should see categories submenu$/ do
  all('.nav .dropdown-menu li>a').should have(3).items
end