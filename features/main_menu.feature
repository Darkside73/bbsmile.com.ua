Feature: Main menu
  In order to access site pages
  main menu should contain links
  to those pages

  Scenario: Catalog item present
    Given I am on home page
    Then I should see "Каталог"
