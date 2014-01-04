class SmsSendJob < Struct.new(:phone, :message)
  def perform
    require 'service/sms'
    Service::Sms.new.send phone, message
  end
end
