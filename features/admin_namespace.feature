Feature: Admin Engine
  In order to administrate site
  As a administrator
  I want to access admin page

  Scenario: Enter to admin with default credentials
    When I go to main admin page
      And Enter user "admin" and password "Y5petRup"
    Then I should see admin page