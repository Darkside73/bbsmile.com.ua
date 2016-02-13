# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += [
  'tinymce/*.js', 'tinymce/*.css', 'tinymce/plugins/youtube/*.html'
]
Rails.application.config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif *.ttf *.eot *.svg *.woff 404.html 500.html)

Rails.application.config.assets.paths << Rails.root.join('app/assets/html')
Rails.application.config.assets.register_mime_type('text/html', '.html')
