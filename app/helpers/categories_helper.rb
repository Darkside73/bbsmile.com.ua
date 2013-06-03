module CategoriesHelper
  def category_menu_items
    items = if @category.has_children?
      @category.children
    else
      @category.siblings
    end
    items.reject(&:hidden)
  end

  def link_to_sortable_price(name, direction)
    content_tag :li, class: (direction == sort_direction ? 'active' : '') do
      link_to name, category_page_path(params.merge(sort: 'price', direction: direction))
    end
  end

  def link_to_add_tag(name)
    tags = (selected_tags + [name]).uniq
    content_tag :li, class: (selected_tags.include?(name) ? 'active' : '') do
      link_to name, category_page_path(params.merge(tags: tags))
    end
  end

  def remove_tag_path(name)
    tags = selected_tags - [name]
    category_page_path(params.merge(tags: tags))
  end
end