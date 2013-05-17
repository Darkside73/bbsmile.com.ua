Feature: Static pages
  In order to display information about store,
  delivery terms, etc.
  As a user
  I want to access this pages from information page

Scenario: Access information page
  Given I am on home page
    And Some published pages
  When I click "Информация"
  Then I should see "Информация" in h1 tag
    And I should see "Информация" in page title
    And I should see link "Доставка" in page content
    And I should see link "Оплата" in page content
    And I should see link "Гарантии" in page content

Scenario: Access hidden page
  Given Hidden page
  Then Hidden page should be inaccessible