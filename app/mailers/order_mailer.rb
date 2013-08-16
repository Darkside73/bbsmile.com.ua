class OrderMailer < ActionMailer::Base
  default from: "Babysmile <bbsmile@bbsmile.com.ua>"

  def new_order(order)
    @order = order
    mail to: order.user.email, subject: I18n.t('mailers.order.new_order.subject')
  end
end
