require 'httparty'
require 'digest/md5'

module Service
  class Novaposhta
    include HTTParty
    base_uri 'https://api.novaposhta.ua/v2.0/json'

    def initialize()
      @options = Options.new(Rails.application.secrets.novaposhta['key'])
    end

    def cities
      Rails.cache.fetch('novaposhta/cities', expires_in: 1.day) do
        cities = invoke @options.build('Address', 'getCities')
        warehouses = invoke @options.build('Address', 'getWarehouses')
        cities[:data].map do |city|
          {
            name: city["DescriptionRu"],
            ref: city["Ref"],
            warehouses: warehouses[:data].select do |warehouse|
              warehouse["CityRef"] == city["Ref"]
            end.map { |w| { name: w["DescriptionRu"], ref: w["Ref"] } }
          }
        end
      end
    end

    class Options
      def initialize(key)
        @key = key
      end

      def build(model, method, args = {})
        {
          apiKey: @key,
          modelName: model,
          calledMethod: method,
          methodProperties: args
        }.to_json
      end
    end

    private

    def invoke(body)
      response = self.class.post("/", { body: body })
      response = JSON.parse(response.body).symbolize_keys
      raise response[:errors].join unless response[:success]
      response
    end
  end
end
