class ManagerMailer < ActionMailer::Base
  default to:   Settings.managers_emails,
          from: "notifier@bbsmile.com.ua"

  def new_order(order)
    @order = order
    mail subject: I18n.t('mailers.system.new_order.subject', order_id: order.id)
  end

  def contact_message(contact)
    @contact = contact
    mail subject: I18n.t('mailers.contacts.new_contact.subject')
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
