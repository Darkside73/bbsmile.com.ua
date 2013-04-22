Feature: Products management
  As a administrator
  I want to manage products

Scenario: Add new product
  Given Leaf category "Детская мебель"
  When I go to admin page
    And I click "Новый товар"
    And I select "Детская мебель" from "product[category_id]"
    And fill in "product[page_attributes][title]" with "Кроватка"
    And fill in "product[page_attributes][url]" with "krovatka"
    And uncheck "product[available]"
    And press button "Создать"
  Then I should see "Кроватка"