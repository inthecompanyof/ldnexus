require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
require_relative 'preinitializer'
Bundler.require(:default, Rails.env)

module Help
  class Application < Rails::Application
    config.action_controller.include_all_helpers = true
  end
end
