class CategoriesController < ApplicationController

  def show
    @category = Page.visible.find_by_url!(params[:slug]).pageable
  end
end