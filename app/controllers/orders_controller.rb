class OrdersController < ApplicationController
  before_action :reject_spam

  def create
    cart.attributes = order_params
    respond_to do |format|
      if cart.save
        flash_message = I18n.t(
          'flash.message.orders.created',
          order_id: cart.id,
          when_callback: I18n.t("flash.message.orders.call_#{when_callback}")
        )
        format.json do
          flash.now[:success] = flash_message
          render json: cart.as_json.merge(flashes_in_json), status: :created
          reset_cart
        end
        format.html do
          flash[:success] = flash_message
          redirect_to cart_checkout_path
          reset_cart
        end
      else
        format.json { render json: cart.errors, status: :unprocessable_entity }
        format.html { render 'cart/checkout' }
      end
    end
  end

  private

  def order_params
    params.require(:order).permit(
      :variant_id, :notes,
      user_attributes: [:first_name, :last_name, :email, :phone, :subscribed]
    )
  end

  def when_callback
    case Time.current.hour
    when 9..19
      'now'
    when 19..23
      'tomorrow'
    else
      'morning'
    end
  end

  def reject_spam
    render nothing: true, status: 403 if params[:text].present?
  end
end
