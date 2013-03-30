class MainController < ApplicationController

  layout "layout_main"

  def index
    @categories = Category.includes(:page).arrange
  end
end