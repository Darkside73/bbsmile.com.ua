class CategoriesController < ApplicationController
  helper_method :sort_direction, :selected_tags

  def show
    @category = pageable_from_slug
    @products = @category.products_grid(params)
  end

  def sort_direction
    params[:direction] || 'asc'
  end

  def selected_tags
    params[:tags] || []
  end
end