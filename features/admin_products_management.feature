Feature: Products management
  As a administrator
  I want to manage products

Scenario: Add new product
  When I go to admin page
    And I click "Новый товар"
    And fill in "product[page_attributes][title]" with "New Product"
    And fill in "product[page_attributes][url]" with "new-product"
    And press button "Создать"
  Then I should see "New product"