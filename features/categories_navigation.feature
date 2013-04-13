Feature: Categories navigation
  In order to display categories and subcategories
  As a user
  I want to navigate throught categories hierarchy

Background:
  Given Some category and subcategories
    And I am visit category page

Scenario: Root category page
  Then I should see subcategories list

Scenario: Not root category page without own categories
  When I visit subcategory without own categories page
  Then I should see it siblings
    And I should see active current category