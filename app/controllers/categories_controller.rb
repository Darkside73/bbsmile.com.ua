class CategoriesController < ApplicationController
  helper_method :sort_direction, :selected_tags, :selected_brands

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

  def selected_brands
    params[:brands] || []
  end
end