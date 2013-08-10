Given(/^Some brands$/) do
  @brands = create_list :brand_with_content, 3
end

Then(/^I should see brands list$/) do
  all('.brands-list a.name').collect(&:text).should =~ @brands.collect(&:name)
end

When(/^I click on brand link$/) do
  @brand = @brands.first
  click_link @brand.name
end

When(/^I click on brand edit link$/) do
  @brand = @brands.first
  find("a.btn[href='#{edit_admin_brand_path(@brand)}']").click
end

When(/^I go to subbrand edit$/) do
  @subbrand = @brands.first.children.first
  visit url_for [:edit, :admin, @subbrand]
end
