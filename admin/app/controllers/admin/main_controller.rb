module Admin
  class MainController < ApplicationController
    def index
      render text: 'main#index action in admin engine'
    end
  end
end