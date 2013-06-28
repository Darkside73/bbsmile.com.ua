module Admin::ApplicationHelper
  include ApplicationHelper

  def render_form_for_category(category = nil, url= nil)
    render partial: 'form', locals: { category: category.blank? ? @category : category, url: url }
  end

  def breadcrumb_items
    items = []
    if @product.present? && !@product.new_record?
      items += @product.category.ancestors
      items << @product.category
      items << @product
    elsif @category.present?
      items += @category.ancestors
      items << @category
    end
    items
  end
end