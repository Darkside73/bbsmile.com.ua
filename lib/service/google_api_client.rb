module Service
  module GoogleApiClient
    extend self

    def access_token
      client = Google::APIClient.new(
        application_name: 'bbsmileua', application_version: '0.0.1'
      )
      key = Google::APIClient::KeyUtils.load_from_pkcs12(
        Rails.root.join('data/bbsmileua-1d8fc82bd181.p12'), 'notasecret'
      )

      asserter = Google::APIClient::JWTAsserter.new(
          '473486660521-drfbb8osfpcg1karjh9om6vrc9ure6cb@developer.gserviceaccount.com',
          [
            'https://www.googleapis.com/auth/drive',
            'https://spreadsheets.google.com/feeds/',
            'https://docs.google.com/feeds/',
            'https://docs.googleusercontent.com/'
          ],
          key
      )
      client.authorization = asserter.authorize
      client.authorization.access_token
    end
  end
end
