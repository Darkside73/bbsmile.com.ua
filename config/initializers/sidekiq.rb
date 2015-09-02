require 'sidekiq'
require 'sidekiq-status'

Sidekiq.configure_client do |config|
  config.client_middleware do |chain|
    chain.add Sidekiq::Status::ClientMiddleware
  end
  config.redis = { namespace: Rails.env, url: "redis://127.0.0.1:6379/#{Rails.env.staging? ? 1 : 0}" }
end

Sidekiq.configure_server do |config|
  config.server_middleware do |chain|
    chain.add Sidekiq::Status::ServerMiddleware, expiration: 30.minutes # default
  end
  config.redis = { namespace: Rails.env, url: "redis://127.0.0.1:6379/#{Rails.env.staging? ? 1 : 0}" }
end
