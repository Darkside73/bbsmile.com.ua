class Admin::OrdersController < Admin::ApplicationController
  helper_method :filter_params

  def index
    params[:status] ||= "placed"
    @orders = Order.where(orders_where_condition).page(params[:page])
  end

  def show
    @order = Order.includes(suborders: [variant: :product]).find params[:id]
  end

  def update
    order = Order.find params[:id]
    order.update! order_params
    OrderMailer.approved(order).deliver_later
    SmsSendJob.perform_later(
      order.phone_number,
      I18n.t('mailers.order.approved.sms', order_id: order.number)
    )
    redirect_to [:admin, order], notice: I18n.t('flash.message.orders.approved')
  end

  private

  def filter_params(filter)
    params.except(:action, :controller).merge(filter)
  end

  def orders_where_condition
    condition = {}
    %w(payment_method status).each do |name|
      # TODO: replace by "payment_method: params[:payment_method]"
      condition[name] = Order.send(name.pluralize)[params[name]] if params[name]
    end
    condition
  end

  def order_params
    params.require(:order).permit(:status)
  end
end
