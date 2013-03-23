module Admin::ApplicationHelper

  def controller?(*controller)
    controller.include?(params[:controller])
  end

  def action?(*action)
    action.include?(params[:action])
  end

  def unless_active_attr(page)
    controller?(page) ? {class: :active} : {}
  end

  def render_form_for_category(category = nil, url= nil)
    render partial: 'form', locals: { category: category.blank? ? @category : category, url: url }
  end
end