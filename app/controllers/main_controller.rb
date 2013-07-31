class MainController < ApplicationController
  layout "layout_main"
  helper_method :novelties, :discounts, :hits

  def index
    @categories = Category.arrange
    @order = Order.new
    @order.build_user
  end

  private

  def novelties
    Product.novelties.random(3)
  end

  def discounts
    Product.discounts.random(3)
  end

  def hits
    Product.hits.random(3)
  end
end
