class CategoriesController < ApplicationController

  def show
    @category = pageable_from_slug
    @products = @category.products_grid(params)
  end
end