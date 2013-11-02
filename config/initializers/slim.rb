# Allow Slim assets in the asset pipeline
Rails.application.assets.register_engine('.slim', Slim::Template)
