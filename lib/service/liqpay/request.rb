module Service
  module Liqpay
    class Request
      SUCCESS_STATUSES = %w(success sandbox)

      def initialize(liqpay, raw_data)
        @liqpay = liqpay
        @raw_data = raw_data
      end

      def valid?(signature)
        @liqpay.str_to_sign(private_key + @raw_data + private_key) == signature
      end

      def data
        @data ||= JSON.parse(Base64.decode64 @raw_data)
      end

      def success?
        @data && SUCCESS_STATUSES.include?(@data['status'])
      end

      private

      def private_key
        Rails.application.secrets.liqpay['private_key']
      end
    end
  end
end
