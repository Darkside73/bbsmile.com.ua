Feature: Price ranges management
  As a administrator
  I want to manage category price ranges

Background:
  Given Some category

Scenario: Add new price range
  When I go to this category edit
    And I click "Диапазоны цен"
    And fill in "price_range[from]" with "1500"
    And fill in "price_range[to]" with "2000"
    And press button "Создать"
  Then I should see "1500"
    And I should see "2000"