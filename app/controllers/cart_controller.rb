class CartController < ApplicationController

  def add_item
    cart.user = nil
    cart.suborders << Suborder.new(suborder_params)
    render cart
  end

  def delete_item
    cart.remove_suborder(params[:index].to_i)
    render cart
  end

  def update
    cart.errors.clear
    cart.update_suborder(params[:index].to_i, params[:quantity].to_i)
    render cart
  end

  def index
    render cart
  end

  def checkout
    cart.errors.clear
    cart.build_user
  end

  private

  def suborder_params
    params.permit(:variant_id, :quantity, :offer_id)
  end
end
