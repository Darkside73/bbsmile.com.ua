# Allow Slim assets in the asset pipeline
Rails.application.config.assets.configure do |env|
  env.register_transformer 'text/slim', 'text/html', Slim::Template
  env.register_mime_type 'text/slim', extensions: ['.html']
end

Slim::Engine.set_options attr_list_delims: {'(' => ')', '[' => ']'}
