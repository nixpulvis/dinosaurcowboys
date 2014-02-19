require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module PartyShark
  class Application < Rails::Application
    require 'party_shark'

    # Handle errors internally.
    config.exceptions_app = -> (env) do
      ExceptionsController.action(:show).call(env)
    end

    # I'm not localizing this application.
    config.i18n.enforce_available_locales = false
  end
end
