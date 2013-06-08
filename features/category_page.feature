Feature: Category page
  As a user
  I want to see products on category page

Background:
  Given Category with products

Scenario: Product list
  When I open this category page
  Then I should see products with prices