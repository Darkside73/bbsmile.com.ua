class MainController < ApplicationController

  layout "layout_main"

  def index
    @categories = Category.arrange
  end
end