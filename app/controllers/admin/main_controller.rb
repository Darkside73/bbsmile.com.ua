class Admin::MainController < Admin::ApplicationController

  def index
    @categories = Category.arrange
  end
end
