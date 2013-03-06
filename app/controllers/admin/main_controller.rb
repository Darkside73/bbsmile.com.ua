module Admin
  class MainController < ApplicationController

    def index
      @categories = Category.arrange
    end
  end
end