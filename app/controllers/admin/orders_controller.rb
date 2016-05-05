class Admin::OrdersController < Admin::ApplicationController
  helper_method :filter_params

  def index
    @orders = Order.where(orders_where_condition).page(params[:page])
  end

  def show
    @order = Order.includes(:suborders).find params[:id]
  end

  def update
    order = Order.find params[:id]
    order.update! order_params
    redirect_to [:admin, order]
  end

  private

  def filter_params(filter)
    params.except(:action, :controller).permit!.merge(filter)
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
    params.require(:order).permit(:status, :total_correction)
  end
end
