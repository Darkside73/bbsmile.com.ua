Then /I should get a response with status (\d+)/ do |code|
  page.status_code.should be_equal(code.to_i)
end