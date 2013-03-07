When(/^Enter user "(.*?)" and password "(.*?)"$/) do |user, password|
  page.status_code.should == 401
  basic_auth user, password
  visit admin_path
end

Then /I should see admin page/ do
  page.should have_content('admin')
end