Feature: Categories management
  As a administrator
  I want to manage catalog categories

Background:
  Given Some categories and subcategories

Scenario: Root categories list
  When I go to admin categories page
  Then I shoud see root categories list

Scenario: Subcategories list
  When I click on category link
  Then I shoud see it subcategories list

Scenario: Add new category
  When I click on new category link
    And fill in category title field and category url field
    And press submit button
  Then I shoud see created category in categories list

Scenario: Edit category
  When I click on edit category link
    And fill in category title field with "New title"
    And press submit button
  Then I shoud see category with title "New title" in categories list

Scenario: Add new subcategory
  When I click on add new subcategory link
    And fill in title field and url field
    And select parent category
    And press submit button
  Then I shoud see created subcategory in subcategories list