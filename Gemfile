source 'https://rubygems.org'

gem 'rails', '4.0.0'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'pg'
gem 'pg_search'
gem 'ancestry', github: 'stefankroes/ancestry', branch: 'master'
gem 'nilify_blanks'
gem 'randumb'

gem 'russian'

gem 'slim', github: 'slim-template/slim'
# gem 'slim-rails', github: 'slim-template/slim-rails'
gem 'cells'
gem 'simple_form', '>= 3.0.0beta1'
gem 'attribute_normalizer'
gem 'acts_as_list'
gem 'acts-as-taggable-on', github: 'mbleigh/acts-as-taggable-on'

gem 'jquery-rails', '~> 2.2.1'
gem 'json', '~> 1.7.7'
gem 'bootstrap-wysihtml5-rails'
gem 'bootstrap-components-helpers', github: 'Darkside73/bootstrap-components-helpers'
gem 'paperclip'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'less-rails-bootstrap'
  gem 'font-awesome-rails'
  gem 'coffee-rails', '>= 4.0.0beta1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

group :development do
  # Freeze rake version due some instability
  gem 'rake', '10.0.4'
  gem 'seedbank'
  gem 'rb-inotify', require: false
  gem 'guard-rspec'
  gem 'guard-cucumber'
  gem 'guard-zeus-client'
  gem 'meta_request', '0.2.5'
end

group :development, :test do
  gem 'rspec-rails', '~> 2.13.0'
  gem 'factory_girl_rails'
  gem 'faker'
end

group :test do
  gem 'cucumber-rails', require: false, github: 'cucumber/cucumber-rails', branch: 'master_rails4_test'
  gem 'capybara'
  gem 'shoulda'
  gem 'launchy'
  gem 'database_cleaner'
end


# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano'

# To use debugger
# gem 'debugger'
