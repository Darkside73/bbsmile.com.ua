module Admin::ApplicationHelper
  def render_form_for_category(category = nil, url= nil)
    render 'form', category: category.blank? ? @category : category, url: url
  end
end