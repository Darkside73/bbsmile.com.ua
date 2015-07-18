class CartController < ApplicationController
  respond_to :json

  def add_item
    respond_with(cart, location: cart_add_item_url) do
      cart.suborders << Suborder.new(suborder_params)
      cart.validate
    end
  end

  def delete_item
    cart.remove_suborder(params[:index].to_i)
    respond_with cart
  end

  private

  def suborder_params
    params.permit(:variant_id, :quantity)
  end

  def cart
    session[:cart] ||= Order.new
  end
end
