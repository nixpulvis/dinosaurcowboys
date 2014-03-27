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
  before_action do
    response.headers['X-XSS-Protection'] = '0'
  end

  # Ensure authorization.
  after_action :verify_authorized, except: :index,
                                   unless: :insecure_controller?
  after_action :verify_policy_scoped, only: :index,
                                      unless: :insecure_controller?

  protected

  # Check if the controller is a controller that should not have
  # authorizations run on it.
  def insecure_controller?
    devise_controller? || exceptions_controller?
  end

  # Check if the controller is an exception controller.
  def exceptions_controller?
    is_a?(ExceptionsController)
  end

  # Follow requests through on sign in.
  def after_sign_in_path_for(resource)
    params[:redirect] || super
  end
end
