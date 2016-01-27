require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Bbsmile
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.autoload_paths += %W(#{config.root}/lib)

    config.active_job.queue_adapter = :sidekiq

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Kyiv'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :ru
    I18n.config.enforce_available_locales = true

    config.use_webpack = true

    config.active_support.escape_html_entities_in_json = true

    config.action_controller.action_on_unpermitted_parameters = :raise
    config.action_controller.always_permitted_parameters = %w(controller action format)

    config.react.addons = true

    config.generators do |g|
      g.test_framework :rspec,
        fixtures: true, # specifies to generate a fixture for each model (using a Factory Girl factory, instead of an actual fixture
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        controller_specs: false,
        request_specs: false
      g.fixture_replacement :factory_girl, dir: "spec/factories" # generate factories instead of fixtures
    end
  end
end
