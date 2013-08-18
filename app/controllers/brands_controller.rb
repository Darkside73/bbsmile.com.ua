class BrandsController < ApplicationController

  def show
    @brand = Brand.find_by! name: params[:name]
  end
end
