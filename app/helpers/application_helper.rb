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