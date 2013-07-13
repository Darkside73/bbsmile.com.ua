class ManagerMailer < ActionMailer::Base
  default from: "notifier@bbsmile.com.ua"

  def new_order(order)
    @order = order
    mail to: Settings.managers_emails, subject: 'New order'
  end
end
