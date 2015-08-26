class ManagerMailer < ActionMailer::Base
  default to:   Settings.managers_emails,
          from: "notifier@bbsmile.com.ua"

  def new_order(order)
    @order = order
    mail subject: I18n.t('mailers.system.new_order.subject', order_id: order.id)
  end

  def paid_order(order)
    @order = order
    mail subject: I18n.t('mailers.system.paid_order.subject', order_id: order.id)
  end

  def order_payment(order, transaction_uid)
    @order = order
    @payment = Payment.find_by transaction_uid: transaction_uid
    mail subject: I18n.t('mailers.system.order_payment.subject', order_id: order.id)
  end

  def contact_message(contact)
    @contact = contact
    mail subject: I18n.t('mailers.contacts.new_contact.subject')
  end

  def callback_message(callback)
    @callback = callback
    mail subject: I18n.t('mailers.callbacks.new_callback.subject')
  end

  def quick_order_message(quick_order)
    @quick_order = quick_order
    mail subject: I18n.t('mailers.callbacks.quick_order.subject')
  end

  def sync_prices_loaded(category)
    @category = category
    mail subject: I18n.t('mailers.system.sync_prices_loaded.subject')
  end

  def sync_products_loaded(category)
    @category = category
    mail subject: I18n.t('mailers.system.sync_products_loaded.subject')
  end
end
