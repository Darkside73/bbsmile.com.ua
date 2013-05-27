Feature: Product variants management
  As a administrator
  I want to manage product variants

Background:
  Given Some product

Scenario: Add new variant
  When I go to this product
    And I click "Цены"
    And fill in "variant[name]" with "зеленый цвет"
    And fill in "variant[price]" with "10.10"
    And fill in "variant[sku]" with "code123"
    And attach the file "product_image.jpg" to "variant[image_attributes][attachment]"
    And I check "variant[master]"
    And I uncheck "variant[available]"
    And press button "Создать"
  Then I should see "code123"
    And I should see "зеленый цвет"
    And variant should have image

Scenario: Edit variant
  Given Product with variants
  When I go to this product
    And I click "Цены"
    And I click "Редактировать" for some variant
    And fill in "variant[name]" with "красный цвет"
    And press button "Обновить"
  Then I should see "красный цвет"

Scenario: Delete image
  Given Variant with image
  When I go to this variant edit
    And I check "variant[delete_image]"
    And press button "Обновить"
  Then variant should not have image
