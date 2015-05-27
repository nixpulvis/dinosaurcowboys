require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module DinosaurCowboys
  class Application < Rails::Application
    require 'dinosaur_cowboys'

    config.middleware.use(Rack::Attack)

    # Usage: `Rails.cache.write('block 1.2.3.4', true, expires_in: 5.days)`
    Rack::Attack.blacklist('block <ip>') do |req|
      Rails.cache.fetch("block #{req.ip}").present?
    end

    # Redirect requests to dinosaurcowboys.herokuapp.com to our domain.
    config.middleware.insert_before(Rack::Runtime, Rack::Rewrite) do
      r301 %r{.*}, 'http://www.dinosaurcowboys.rodeo$&', :if => Proc.new { |env|
        env['SERVER_NAME'] == 'dinosaurcowboys.herokuapp.com'
      }
    end

    # Handle errors internally.
    config.exceptions_app = -> (env) do
      ExceptionsController.action(:show).call(env)
    end

    # I'm not localizing this application.
    config.i18n.enforce_available_locales = false
  end
end
