class OrdersController < ApplicationController
  before_action :reject_spam

  def create
    cart.attributes = order_params
    respond_to do |format|
      if cart.save
        message = render_to_string(
          partial: 'success.html', locals: { order: cart }
        )
        format.json do
          render json: cart.as_json.merge(flash: message), status: :created
          reset_cart
        end
      else
        format.json { render json: cart.errors, status: :unprocessable_entity }
      end
    end
  end

  def pay
    @order = Order.pending.find_by! uuid: params[:uuid]
    options = {
      version: "3",
      amount: @order.total,
      currency: "UAH",
      description: @order.description,
      order_id: @order.number,
      server_url: order_api_callback_url
    }
    options[:sandbox] = 1 if Settings.liqpay.sandbox
    @pay_button = liqpay.cnb_form options
  end

  def api_callback
    request = Service::Liqpay::Request.new liqpay, params[:data]
    if request.valid?(params[:signature])
      data = request.data
      order = Order.pending.find data['order_id']

      order.payments_attributes = [{
        amount:          data['amount'],
        transaction_uid: data['transaction_id'],
        account:         data['sender_phone'],
        status:          data['status']
      }]
      order.status = :paid if request.success?
      order.save!

      ManagerMailer.order_payment(order, data['transaction_id'])
                   .deliver_later unless request.success?

      render nothing: true
    else
      render nothing: true, status: 400
    end
  end

  private

  def order_params
    params.require(:order).permit(
      :notes, :payment_method, :delivery_info, :delivery_method, :address,
      user_attributes: [:first_name, :last_name, :email, :phone, :subscribed]
    )
  end

  def reject_spam
    render nothing: true, status: 403 if params[:text].present?
  end

  def liqpay
    @liqpay ||= Liqpay.new(
      Rails.application.secrets.liqpay.to_hash.symbolize_keys
    )
  end
end
