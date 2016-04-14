class CartController < ApplicationController
  respond_to :json, only: :cities

  def add_item
    cart.user = nil
    cart.suborders << Suborder.new(suborder_params)
    update_cart_in_session
    render cart
  end

  def delete_item
    cart.remove_suborder(params[:index].to_i)
    update_cart_in_session
    render cart
  end

  def update_item
    cart.errors.clear
    cart.update_suborder(params[:index].to_i, params[:quantity].to_i)
    update_cart_in_session
    render cart
  end

  def index
    render cart
  end

  def update
    cart.attributes = order_params
    cart.validate
    render cart
  end

  def checkout
    cart.errors.clear
    cart.build_user
  end

  def cities
    respond_with Service::Novaposhta.new.cities
  end

  private

  def suborder_params
    params.permit(:variant_id, :quantity, :offer_id)
  end

  def order_params
    params.permit(:payment_method)
  end
end
