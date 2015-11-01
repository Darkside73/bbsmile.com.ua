module ApplicationHelper

  def title(page_title)
    seo_page.title = page_title
    content_for(:title) { page_title }
  end

  def default_stylesheet
    case current_layout
    when 'layout_main'
      'main'
    when 'layout_inner'
      'inner'
    end
  end

  def link_to(*args)
    where_page = Proc.new { |a| a.is_a?(Page) || a.respond_to?(:page) }
    if page = args.find(&where_page)
      url = "/#{page.url}"
      index_where_page = args.index &where_page
      if index_where_page == 0
        title = page.name
      elsif index_where_page == 1
        title = args.first
      else
        raise ActionView::TemplateError,
          "Page object given as #{index_where_page + 1} argument but expecting as 1 or 2"
      end
      super title, url, *args.drop(index_where_page + 1)
    else
      super
    end
  end

  def flash_class(level)
    case level
    when :notice then "info"
    when :alert then "block"
    when :error then "danger"
    else level.to_s
    end
  end

  def controller?(*controller)
    controller.include?(params[:controller])
  end

  def action?(*action)
    action.include?(params[:action])
  end

  def unless_active_attr(controller, action = nil)
    controller?(controller) && (action.nil? || action?(action)) ? {class: :active} : {}
  end

  def unless_catalog_active_attr
    controller?('categories', 'products') ? {class: :active} : {}
  end

  def unless_url_active_attr(url)
    /^#{url}/ =~ params[:slug] ? {class: :active} : {}
  end

  def body_attributes
    case controller.controller_name
    when 'main' then { data: { spy: 'scroll', target: '.subnav', offset: 150 } }
    else
      {}
    end
  end

  def suggest_search_sample
    Settings.misc.search_suggestions.split(',').map(&:strip).sample
  end

  def new_order
    order = Order.new
    order.build_user
    order
  end

  def admin_actions_links
    links = []
    if @current_page.respond_to? :pageable
      pageable = @current_page.pageable
      links << link_to('Просмотр', admin_url_for([:admin, pageable]))
      links << link_to('Редактировать', admin_url_for([:edit, :admin, pageable]))
      if pageable.is_a?(Category) && pageable.leaf?
        links << link_to('Добавить товар', admin_url_for([:new, :product, :admin, pageable]))
        links << link_to_add_or_edit_content(pageable)
      end
      if pageable.is_a? Product
        links << link_to_add_or_edit_content(pageable)
        links << link_to('Характеристики', admin_url_for([:properties, :admin, pageable]))
        links << link_to('Фото', admin_url_for([:admin, pageable, :images]))
        links << link_to('Цены', admin_url_for([:admin, pageable, :variants]))
        links << link_to('Акции', admin_url_for([:admin, pageable, :offers]))
      end
    end
    links
  end

  def render_component(component)
    render "application/components/#{component}"
  end

  def seo_meta_tags
    seo_page.meta_tags
  end

  private
    def current_layout
      layout = controller.send(:_layout)
      if layout.instance_of? String
        layout
      else
        File.basename(layout.identifier).split('.').first
      end
    end

    def link_to_add_or_edit_content(pageable)
      if pageable.content.present?
        link_to 'Описание', admin_url_for([:edit, :admin, :product, pageable.content])
      else
        link_to 'Описание', admin_url_for([:new, :admin, pageable, :content])
      end
    end

    def admin_url_for item
      polymorphic_url item, domain: 'bbsmile.com.ua', subdomain: ''
    end
end
