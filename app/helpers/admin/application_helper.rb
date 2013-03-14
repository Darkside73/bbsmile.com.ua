module Admin::ApplicationHelper
  def render_form_for_category(category = nil, url= nil)
    render partial: 'form', locals: { category: category.blank? ? @category : category, url: url }
  end
end