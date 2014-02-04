# ApplicationController
# The base controller for this application. All logic that applies to
# every action should be defined here.
#
class ApplicationController < ActionController::Base
  include Pundit

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Allowing things like iframes in content of the site requires this.
  # The browser by default shits itself if a response comes back with
  # the same script-like data sent.
  before_filter do
    response.headers['X-XSS-Protection'] = '0'
  end

  # Ensure authorization.
  after_filter :verify_authorized, except: :index, unless: :devise_controller?
  after_filter :verify_policy_scoped, only: :index, unless: :devise_controller?

  # Don't error 500 when people try to access bad things,
  # pretend like it's just not found.
  rescue_from Pundit::NotAuthorizedError do |e|
    fail ActionController::RoutingError, e.message
  end
end
