Feature: Products management
  As a administrator
  I want to manage products

Background:
  Given Leaf category "Детская мебель"

Scenario: Add new product
  When I go to admin page
    And I click "Новый товар"
    And I select "Детская мебель" from "product[category_id]"
    And fill in "product[page_attributes][title]" with "Кроватка"
    And fill in "product[page_attributes][url]" with "krovatka"
    And fill in "product[price]" with "10.10"
    And fill in "product[sku]" with "code123"
    And I uncheck "product[available]"
    And press button "Создать"
  Then I should see "Кроватка"

Scenario: Add new product in category
  Given I go to this category
  When I click "Добавить товар"
    And fill in "product[page_attributes][title]" with "Кроватка"
    And fill in "product[page_attributes][url]" with "krovatka"
    And press button "Создать"
  Then This product "Кроватка" should belongs to current category

Scenario: View products in leaf category
  Given Some products in category
    And I go to this category
  Then I should see this products

Scenario: Edit product
  Given Some product
  When I go to this product edit
    And fill in "product[page_attributes][title]" with "Другая кроватка"
    And press button "Обновить"
  Then I should see "Другая кроватка"

Scenario: View product
  Given Some product
  When I go to this product
  Then I should see product properties
