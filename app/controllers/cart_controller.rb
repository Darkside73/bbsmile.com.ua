class CartController < ApplicationController
  respond_to :json, except: :delete_item # responder render empty response for DELETE requests; so turn it off

  def add_item
    respond_with(cart, location: cart_add_item_url) do
      cart.suborders << Suborder.new(suborder_params)
    end
  end

  def delete_item
    cart.remove_suborder(params[:index].to_i)
    respond_with(cart) do |format|
      format.js { render json: cart }
    end
  end

  def index
    render json: cart
  end

  private

  def suborder_params
    params.permit(:variant_id, :quantity)
  end

  def cart
    session[:cart] ||= Order.new
  end
end
