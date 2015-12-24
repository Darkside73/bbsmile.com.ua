module CategoriesHelper
  def category_menu_items
    items = if @category.has_children?
      @category.children
    else
      @category.siblings
    end
    items.visible.includes(:page)
  end

  def accordion_group(id, name, options = {}, &block)
    return nil if options[:if] && @category.send(options[:if]).empty?
    render layout: 'accordion_group', locals: { id: id, name: name, attrs: options.fetch(:attrs, {}) } do
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
    link_to_add_or_remove_filter :tag, name, tags
  end

  def remove_tag_path(name)
    tags = selected_tags - [name]
    category_page_path(params.merge(tags: tags))
  end

  def link_to_add_brand(name)
    brands = (selected_brands + [name]).uniq
    link_to_add_or_remove_filter :brand, name, brands
  end

  def remove_brand_path(name)
    brands = selected_brands - [name]
    category_page_path(params.merge(brands: brands))
  end

  def link_to_add_price_range(price_range, &block)
    id = price_range.id.to_s
    ranges = (selected_prices + [id]).uniq
    link_text = capture &block
    link_to_add_or_remove_filter :price, link_text, ranges, id
  end

  def remove_price_path(price_range)
    id = price_range.respond_to?(:id) ? price_range.id.to_s : price_range
    ranges = selected_prices - [id]
    category_page_path(params.merge(prices: ranges))
  end

  def link_to_add_age_range(age_range, &block)
    ages = (selected_ages + [age_range]).uniq
    link_text = capture &block
    link_to_add_or_remove_filter :age, link_text, ages, age_range
  end

  def remove_age_path(age_range)
    ages = selected_ages - [age_range]
    category_page_path(params.merge(ages: ages))
  end

  def any_filtering?
    selected_prices.any? || selected_brands.any? || selected_tags.any? ||
    selected_ages.any? || selected_gender.present?
  end

  def no_filtering?
    !any_filtering?
  end

  def special_products_cache_key
    updated_at = []
    [:novelties, :discounts, :hits].each do |type|
      updated_at << @category.send(type).last_updated(36).maximum(:updated_at)
    end
    updated_at.reject(&:nil?).max
  end

  def category_title
    title_parts = "#{@category.title} #{selected_brands.join ', '}"
  end

  def offers_path_for_category
    if Category.roots_contained_offers.select { |root| root == @category.root }
      category_offers_path(@category.root.url)
    end
  end

  private

  def link_to_add_or_remove_filter(entity, link_text, items, link_id = nil)
    entities = entity.to_s.pluralize.to_sym
    link_id = link_id ? link_id : link_text
    if self.send("selected_#{entities}").include?(link_id)
      content_tag :li, class: 'active' do
        link_to link_text, self.send("remove_#{entity}_path", link_id), title: 'удалить фильтр'
      end
    else
      content_tag :li do
        link_to "#{link_text}", category_page_path(params.merge({ entities => items }))
      end
    end
  end
end
