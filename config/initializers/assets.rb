# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += [
  'main.css', 'inner.css', 'category.css', 'product.css', 'information_page.css', 'ie.css',
  'font-awesome-ie7.min.css', 'fontawesome-webfont.ttf', 'fontawesome-webfont.eot', 'fontawesome-webfont.svg', 'fontawesome-webfont.woff',
  'product.js', 'category.js', 'admin-panel.js', 'blueimp-gallery/*.svg'
]
Rails.application.config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif 404.html 500.html)

Rails.application.config.assets.paths << Rails.root.join('app/assets/html')
Rails.application.config.assets.register_mime_type('text/html', '.html')
