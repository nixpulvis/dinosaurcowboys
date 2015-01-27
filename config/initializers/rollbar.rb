if Rails.env.production?
  require 'rollbar/rails'
  Rollbar.configure do |config|
    config.access_token = 'aac7434c543b49c587584dc03a293182'
  end
end
