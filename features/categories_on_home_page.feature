Feature: Categories on home page
  In order to convenient access to site catalog
  As a user
  I want to see products categories and subcategories on home page

Background:
  Given Product category "Детские коляски" and subcategory "Прогулочные"

Scenario: Categories on main page
  Given I am on home page
  Then I should see link "Детские коляски" as category
    And I should see link "Прогулочные" as it subcategory