Feature: Brands management
  As a administrator
  I want to manage product brands

Background:
  Given Some brands
    And I am on admin page
    When I click "Бренды"

Scenario: Brands list
  Then I should see brands list

Scenario: Add new brand
  When I click "Добавить бренд"
    And fill in "brand[name]" with "New brand"
    And fill in "brand[content_attributes][text]" with "Some content"
    And press button "Создать"
  Then I should see "New brand"

Scenario: Edit brand
  When I click on brand edit link
    And fill in "brand[name]" with "New name"
    And fill in "brand[content_attributes][text]" with "Some content"
    And press button "Обновить"
  Then I should see "New name"
