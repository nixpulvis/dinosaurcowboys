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
  after_filter :verify_authorized, except: :index,
                                   unless: [:devise_controller?,
                                            :exceptions_controller?]
  after_filter :verify_policy_scoped, only: :index,
                                      unless: [:devise_controller?,
                                               :exceptions_controller?]

  protected

  # Check if the controller is an exception controller.
  def exceptions_controller?
    is_a?(ExceptionsController)
  end

  # Follow requests through on sign in.
  def after_sign_in_path_for(resource)
    if request.referer == user_session_url
      super
    else
      stored_location_for(resource) || request.referer || root_path
    end
  end
end
