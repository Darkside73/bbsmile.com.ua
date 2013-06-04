Given(/^Some category$/) do
  @category = create :category
end

When(/^I go to this category edit$/) do
  visit url_for [:edit, :admin, @category]
end