class CategoriesController < ApplicationController

  def show
    @category = pageable_from_slug
  end
end