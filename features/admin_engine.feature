Feature: Admin Engine
  In order to administrate site
  As a administrator
  I want to access admin page

  Scenario: Empty Admin Engine
    When I go to main admin page
    Then I should get a response with status 200