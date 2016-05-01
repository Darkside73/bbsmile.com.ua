require Rails.root.join("config/environments/production")

Rails.application.configure do
  config.action_mailer.asset_host = "http://staging.bbsmile.com.ua"
end
