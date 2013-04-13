module CategoriesHelper
  def category_menu_items
    if @category.has_children?
      @category.children
    else
      @category.siblings
    end
  end
end