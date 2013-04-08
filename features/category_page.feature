Feature: Category page
  In order to display products
  As a user
  I want to access category page

Background:
  Given Some category and subcategories
    And I am visit category page

Scenario: Show subcategories
  Then I should see subcategories list

Scenario: Show parent categories
  When I visit subcategory with own categories page
  Then I should see it subcategory's siblings
    And I should see it subcategories list in #filterBySubcategory