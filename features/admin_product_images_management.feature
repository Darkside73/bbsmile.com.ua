Feature: Product images management
  As a administrator
  I want to upload product images

Scenario: Add image to product
  Given Some product
  When I go to this product
    And I click "Фото"
    And attach the file "product_image.jpg" to "product_image[attachment]"
    And press button "Загрузить"
  Then I should see uploaded image
