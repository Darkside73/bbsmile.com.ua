When(/^Enter user "(.*?)" and password "(.*?)"$/) do |user, password|
  basic_auth user, password
  visit admin_root_path
end

Then /I should see admin page/ do
  page.should have_content('Админ')
end
