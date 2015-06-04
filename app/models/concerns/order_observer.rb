module OrderObserver
  extend ActiveSupport::Concern

  included do
    after_create :send_messages
  end

  private

  def send_messages
    OrderMailer.new_order(self).deliver_now if self.user.email.present?
    ManagerMailer.new_order(self).deliver_now
    if self.phone_number
      require "#{Rails.root}/app/jobs/sms_send_job"
      Delayed::Job.enqueue SmsSendJob.new(
        self.phone_number, I18n.t('mailers.order.new_order.sms', order_id: self.id)
      )
    end
  end
end
