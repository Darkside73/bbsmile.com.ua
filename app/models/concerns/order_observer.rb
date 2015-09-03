module OrderObserver
  extend ActiveSupport::Concern

  included do
    after_create :send_messages
    after_update :check_status_change
  end

  private

  def send_messages
    OrderMailer.new_order(self).deliver_later if user.email.present?
    ManagerMailer.new_order(self).deliver_later
    if phone_number
      SmsSendJob.perform_later(
        phone_number, I18n.t('mailers.order.new_order.sms', order_id: number)
      )
    end
  end

  def check_status_change
    case changes[:status]
    when ["pending", "paid"]
      OrderMailer.paid(self).deliver_later
      ManagerMailer.paid_order(self).deliver_later
    when ["placed", "pending"]
      OrderMailer.approved(self).deliver_later
      SmsSendJob.perform_later(
        phone_number,
        I18n.t('mailers.order.approved.sms', order_id: number)
      )
    end
  end
end
