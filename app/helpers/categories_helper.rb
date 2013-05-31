module CategoriesHelper
  def category_menu_items
    items = if @category.has_children?
      @category.children
    else
      @category.siblings
    end
    items.reject(&:hidden)
  end
end