Devise.setup do |config|
  require 'devise/orm/active_record'

  config.secret_key = Rails.application.secrets.devise_secret_key
  config.mailer_sender = 'no-reply@dinosaurcowboys.rodeo'
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 10
  config.remember_for = 1.year
  config.password_length = 7..128
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
end
