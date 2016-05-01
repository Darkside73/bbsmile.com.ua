require Rails.root.join("config/environments/production")

Rails.application.configure do
  config.action_mailer.asset_host = "http://beta.bbsmile.com.ua"
end
