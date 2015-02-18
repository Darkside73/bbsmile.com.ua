module OrderObserver
  extend ActiveSupport::Concern

  included do
    after_create :send_messages
  end

  private

  def send_messages
    OrderMailer.new_order(self).deliver_now if self.user.email.present?
    ManagerMailer.new_order(self).deliver_now
  end
end
