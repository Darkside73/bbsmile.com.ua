source 'https://rubygems.org'

gem 'rails', '4.1.4'

gem 'pg'
gem 'pg_search'
gem 'ancestry'
gem 'nilify_blanks'
gem 'acts_as_list'
gem 'acts-as-taggable-on'
gem 'delayed_job'
gem 'delayed_job_active_record'
gem 'daemons'
gem 'newrelic_rpm'

gem 'rails_config'
gem 'russian'
gem 'exception_notification'

gem 'metamagic'
gem 'sitemap_generator'

gem 'slim'
# gem 'slim-rails'
gem 'redcarpet'
gem 'cells'
gem 'simple_form'
gem 'attribute_normalizer', '1.1.0'

gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'json'
gem 'bootstrap-components-helpers', github: 'Darkside73/bootstrap-components-helpers'
gem 'paperclip'
gem 'dimensions-rails', github: 'elia/dimensions-rails'
gem 'tinymce-rails'
gem 'tinymce-rails-langs'

gem 'google_drive', require: false
gem 'httparty', require: false

group :assets do
  gem 'less-rails-bootstrap'
  gem 'font-awesome-rails'
  gem 'coffee-rails'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

group :development do
  gem 'rake'
  gem 'seedbank'
  gem 'rb-inotify', require: false
  gem 'guard', '>=2.1.0'
  gem 'guard-rspec'
  gem 'guard-cucumber'
  # gem 'meta_request', '0.2.5'
  gem 'better_errors'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'rspec-its'
  gem 'rspec-collection_matchers'
  gem 'factory_girl_rails'
  gem 'faker'
end

group :test do
  gem 'minitest'
  gem 'cucumber-rails', require: false
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
gem 'unicorn-worker-killer'

# Deploy with Capistrano
gem 'capistrano'
gem 'rvm-capistrano'

# To use debugger
# gem 'debugger'
