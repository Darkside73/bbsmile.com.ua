module ApplicationHelper
  def title(page_title)
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
        title = page.title
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

  private
    def current_layout
      layout = controller.send(:_layout)
      if layout.instance_of? String
        layout
      else
        File.basename(layout.identifier).split('.').first
      end
    end
end