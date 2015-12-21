# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += [
  'main.css', 'inner.css', 'category.css', 'product.css',
  'information_page.css', 'ie.css', 'font-awesome-ie7.min.css',
  'product.js', 'category.js', 'admin-panel.js',
  'tinymce/plugins/youtube/*.js', 'tinymce/plugins/youtube/*.css', 'tinymce/plugins/youtube/*.html'
]
Rails.application.config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif *.ttf *.eot *.svg *.woff 404.html 500.html)

Rails.application.config.assets.paths << Rails.root.join('app/assets/html')
# Allow Slim assets in the asset pipeline
Rails.application.config.assets.register_mime_type 'text/slim', extensions: ['.slim']
Rails.application.config.assets.register_transformer 'text/slim', 'text/html', Slim::Template
