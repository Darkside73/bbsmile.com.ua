Feature: Categories management
  As a administrator
  I want to manage catalog categories

Background:
  Given Some categories and subcategories
    And I go to admin categories page

Scenario: Root categories list
  Then I should see root categories list

Scenario: Subcategories list
  When I click on category link
  Then I should see it subcategories list

Scenario: Add new category
  When I click on new category link
    And fill in "category[page_attributes][title]" with "New category"
    And fill in "category[page_attributes][name]" with "New category"
    And fill in "category[page_attributes][url]" with "new-category"
    And fill in "category[page_attributes][url_old]" with "category/old/url"
    And press button "Создать"
  Then I should see "New category"

Scenario: Edit category
  When I click on category edit link
    And fill in "category[page_attributes][title]" with "New title"
    And press button "Обновить"
  Then I should see "New title"

Scenario: Add new subcategory
  Given I am viewing some category page
  When I click "Добавить подкатегорию"
    And fill in "category[page_attributes][title]" with "New subcategory"
    And fill in "category[page_attributes][url]" with "new-subcategory"
    And press button "Создать"
    And return to parent category page
  Then I should see "New subcategory"

Scenario: Categories with subcategories could not be a leaves
  Given I am editing some category page
  Then I should not see "конечная категория"

Scenario: Categories without subcategories could be a leaves
  Given I am editing some subcategory page
  When I check "конечная категория"
    And press button "Обновить"
  Then Subcategory should be a leaf

Scenario: Leaf category could not have children
  Given I am viewing some leaf category
  Then I should not see "Добавить подкатегорию"

Scenario: Hidden categories
  Given I am editing some category page
  When I check "скрытая"
    And press button "Обновить"
  Then I should see hidden category
  Then Subcategories should be hidden
  When I go to home page
Then I should not see hidden category