class SmsSendJob < ActiveJob::Base
  queue_as :default

  def perform(phone, message)
    require 'service/sms'
    Service::Sms.new.send phone, message
  end
end
