module VariantObserver
  extend ActiveSupport::Concern

  included do
    after_update :notify_availability,
                 if: -> { available_changed?(from: false, to: true) }
  end

  private

  def notify_availability
    availability_subscribers.each do |subscriber|
      if subscriber.phone
        SmsSendJob.perform_later(
          subscriber.phone,
          I18n.t('mailers.variant.available.sms', title: title)
        )
      end
      if subscriber.email
        VariantMailer.available(self, subscriber.email).deliver_later
      end
    end
    availability_subscribers.delete_all
  end
end
