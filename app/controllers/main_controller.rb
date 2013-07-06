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
    Product.novelties.limit(3)
  end

  def discounts
    Product.discounts.limit(6)
  end

  def hits
    Product.hits.limit(3)
  end
end
