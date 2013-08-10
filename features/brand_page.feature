Feature: Brand page
  As a user
  I want to see brand description and products

Background:
  Given Some brand

Scenario: Brand page
  When I open this brand page
  Then I should see brand description
