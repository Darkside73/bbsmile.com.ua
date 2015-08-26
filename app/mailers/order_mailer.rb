class OrderMailer < ActionMailer::Base
  default from: "Babysmile <smile@bbsmile.com.ua>"

  def new_order(order)
    @order = order
    mail to: order.user.email, subject: I18n.t('mailers.order.new_order.subject')
  end

  def approved(order)
    @order = order
    mail(
      to: order.user.email,
      subject: I18n.t('mailers.order.approved.subject', order_id: order.number)
    )
  end
end
