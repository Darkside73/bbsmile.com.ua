class Admin::RelatedProductsController < Admin::ApplicationController
  include Admin::Related

  def index
    @product = Product.find params[:product_id]
  end

  def pageable
    Product.find params[:product_id]
  end
end
