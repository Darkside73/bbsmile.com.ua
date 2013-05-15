Feature: Products management
  As a administrator
  I want to manage products

Background:
  Given Leaf category "Детская мебель"
    And some brands
      | Kids         |
      | Fisher Price |
      | Geoby        |

Scenario: Add new product
  When I go to admin page
    And I click "Новый товар"
    And I select "Детская мебель" from "product[category_id]"
    And I select "Fisher Price" from "product[brand_id]"
    And fill in "product[page_attributes][title]" with "Кроватка"
    And fill in "product[page_attributes][url]" with "krovatka"
    And fill in "product[price]" with "10.10"
    And fill in "product[sku]" with "code123"
    And attach the file "product_image.jpg" to "product[images_attributes][0][asset]"
    And I uncheck "product[available]"
    And press button "Создать"
  Then I should see "Кроватка"

Scenario: Add new product in category
  Given I go to this category
  When I click "Добавить товар"
    And fill in "product[page_attributes][title]" with "Кроватка"
    And fill in "product[page_attributes][url]" with "krovatka"
    And fill in "product[tag_list]" with "мебель, кроватки"
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

Scenario: Add content
  Given Some product without content
  When I go to this product
    And I click "Описание"
    And I click "Добавить"
    And fill in "content[text]" with "Новое описание"
    And press button "Сохранить"
  Then I should see "Новое описание"

Scenario: Edit content
  Given Some product with content
  When I go to this product
    And I click "Описание"
    And I click "Редактировать"
    And fill in "content[text]" with "Новое описание"
    And press button "Сохранить"
  Then I should see "Новое описание"

Scenario: View product
  Given Some tagged product
  When I go to this product
  Then I should see product properties

Scenario: Add image to product
  Given Some product
  When I go to this product
    And I click "Фото"
    And attach the file "product_image.jpg" to "image[asset]"
    And press button "Загрузить"
  Then I should see uploaded image
