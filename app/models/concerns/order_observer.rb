module OrderObserver
  extend ActiveSupport::Concern

  included do
    after_create :send_messages
  end

  private

  def send_messages
    OrderMailer.new_order(self).deliver_later if self.user.email.present?
    ManagerMailer.new_order(self).deliver_later
    if self.phone_number
      SmsSendJob.perform_later(
        self.phone_number, I18n.t('mailers.order.new_order.sms', order_id: self.id)
      )
    end
  end
end
