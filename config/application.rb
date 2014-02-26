require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

# Silence deprecation warnings
I18n.enforce_available_locales = true

module HaxorNews
  class Application < Rails::Application
    # wow. such insecure. very lab. not production ready.
    config.middleware.use Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any,
          methods: [:head, :get, :post, :patch, :delete, :options]
      end
    end
  end
end
