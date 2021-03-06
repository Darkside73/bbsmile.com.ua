Feature: Categories on home page
  In order to convenient access to site catalog
  As a user
  I want to see products categories and subcategories on home page

Background:
  Given Product category "Детские коляски" and subcategory "Прогулочные"
    And Product category "Детская комната" and subcategories "Кроватки", "Шкафы", "Комоды"

Scenario: Categories on main page
  Given I am on home page
  Then I should see link "Детские коляски" as category
    And I should see link "Прогулочные" as it subcategory

Scenario: Show categories and subcategories by defined position
  Given Following positions
    | Детские коляски |     2    |
    | Прогулочные     |     1    |
    | Детская комната |     1    |
    | Кроватки        |     2    |
    | Комоды          |     1    |
    | Шкафы           |     3    |

  When I go to home page
  Then I should see categories in this order
    | Детская комната |
    | Детские коляски |
    And I should see subcategories from "Детская комната" in this order
      | Комоды   |
      | Кроватки |
      | Шкафы    |
