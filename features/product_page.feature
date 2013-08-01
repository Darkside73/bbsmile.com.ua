Feature: Product page
  As a user
  I want to see information about product
  on the product page

Scenario: Product with multiple price variants
  Given Product with variants
  When I open this product page
  Then I should see variants

Scenario: Product with single price variants
  Given Product with single variant
  When I open this product page
  Then I should not see "Варианты цветов"
