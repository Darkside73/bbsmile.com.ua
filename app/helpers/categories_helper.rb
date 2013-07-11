module CategoriesHelper
  def category_menu_items
    items = if @category.has_children?
      @category.children
    else
      @category.siblings
    end
    items.reject(&:hidden)
  end

  def accordion_group(id, name, options = {}, &block)
    return nil if options[:if] && @category.send(options[:if]).empty?
    render layout: 'accordion_group', locals: { id: id, name: name } do
      capture &block
    end
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

  def link_to_add_brand(name)
    brands = (selected_brands + [name]).uniq
    content_tag :li, class: (selected_brands.include?(name) ? 'active' : '') do
      link_to name, category_page_path(params.merge(brands: brands))
    end
  end

  def remove_brand_path(name)
    brands = selected_brands - [name]
    category_page_path(params.merge(brands: brands))
  end

  def link_to_add_price_range(price_range, &block)
    id = price_range.id.to_s
    ranges = (selected_prices + [id]).uniq
    link_text = capture &block
    content_tag :li, class: (selected_prices.include?(id) ? 'active' : '') do
      link_to link_text, category_page_path(params.merge(prices: ranges))
    end
  end

  def remove_price_range_path(price_range)
    id = price_range.id.to_s
    ranges = selected_prices - [id]
    category_page_path(params.merge(prices: ranges))
  end

  def any_filtering?
    selected_prices.any? || selected_brands.any? || selected_tags.any?
  end

  def no_filtering?
    !any_filtering?
  end
end
