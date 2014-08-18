require 'httparty'
require 'digest/md5'

module Service
  class Sms
    include HTTParty
    base_uri 'atompark.com/api/sms/3.0'

    def initialize
      @options = {
        version: '3.0',
        key: Rails.application.secrets.sms['key']
      }
    end

    def send(phone, message)
      @options[:sender] = 'Babysmile'
      @options[:text] = message
      @options[:phone] = phone
      @options[:datetime] = ''
      @options[:sms_lifetime] = 0

      invoke_remote 'sendSMS' unless Settings.sms.test_mode
    end

    private

    def invoke_remote(service_name)
      @options[:sum] = control_sum(service_name)
      response = self.class.post("/#{service_name}", { body: @options })
      response = JSON.parse(response.body).symbolize_keys
      raise response[:error] if response[:error].present?
      response
    end

    def control_sum(service_name)
      options = @options.dup
      options[:action] = service_name
      sum = Hash[options.sort].values.inject { |sum, v| sum.to_s + v.to_s }
      Digest::MD5.hexdigest sum + Rails.application.secrets.sms['private_key']
    end
  end
end
