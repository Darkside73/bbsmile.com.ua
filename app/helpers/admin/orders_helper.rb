module Admin::OrdersHelper

  def order_status(order)
    labels = {
      placed: 'info',
      pending: 'primary',
      paid: 'success',
      refunded: 'default'
    }
    render 'status', order: order, label: labels.fetch(order.status.to_sym, 'info')
  end

  def order_payment_method(order)
    return unless order.payment_method
    labels = {}
    render 'payment_method', order: order, label: labels.fetch(order.payment_method.to_sym, 'info')
  end
end
