class ManagerMailer < ActionMailer::Base
  default to:   Settings.managers_emails,
          from: "notifier@bbsmile.com.ua"

  def new_order(order)
    @order = order
    mail subject: I18n.t('mailers.order.new_order.subject')
  end

  def price_loaded(category)
    @category = category
    mail subject: I18n.t('mailers.system.price_loaded.subject')
  end
end
