class ManagerMailer < ActionMailer::Base
  default from: "bbsmile@bbsmile.com.ua"

  def new_order(order)
    @order = order
    mail to: 'andrey.garbuz@gmail.com', subject: I18n.t('mailers.order.new_order.subject')
  end
end
