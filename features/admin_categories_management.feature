Feature: Categories management
  As a administrator
  I want to manage catalog categories

Background:
  Given Some categories and subcategories
    And I go to admin categories page

Scenario: Root categories list
  Then I shoud see root categories list

Scenario: Subcategories list
  When I click on category link
  Then I shoud see it subcategories list

Scenario: Add new category
  When I click on new category link
    And fill in "category[title]" with "New category"
    And fill in "category[url]" with "new-category"
    And press button "Создать"
  Then I shoud see category "New category" in categories list

Scenario: Edit category
  When I click on category link
    And fill in "category[title]" with "New title"
    And press button "Обновить"
  Then I shoud see category with title "New title" in categories list

Scenario: Add new subcategory
  Given I am viewing some category page
  When I click on add new subcategory link
    And fill in title field and url field
    And select parent category
    And press button "Добавить"
  Then I shoud see created subcategory in subcategories list