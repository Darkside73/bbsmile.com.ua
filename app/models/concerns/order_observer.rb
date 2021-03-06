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
    SmsSendJob.perform_later(
      user_phone, I18n.t('mailers.order.new_order.sms', order_id: number)
    )
  end

  def check_status_change
    case changes[:status]
    when ["pending", "paid"]
      OrderMailer.paid(self).deliver_later
      SmsSendJob.perform_later(
        user_phone, I18n.t('mailers.order.paid.sms', order_id: number)
      )
    when ["placed", "pending"]
      OrderMailer.approved(self).deliver_later
      SmsSendJob.perform_later(
        user_phone,
        I18n.t(
          'mailers.order.approved.sms',
          order_id: number, total: total_with_currency
        )
      )
    end
  end
end
