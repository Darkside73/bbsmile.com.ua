class OffersController < ApplicationController

  def index
    @offers = if params[:category_slug]
      @category = Category.by_url! params[:category_slug]
      Offer.top.by_category @category
    else
      Offer.top
    end
  end
end
