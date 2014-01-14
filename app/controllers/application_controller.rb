class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  # unauthorized
  # Set the flash, and redirect to home page. This is how to handle
  # people hitting pages they shouldn't.
  #
  def unauthorized
    flash[:alert] = "You do not have access to that."
    redirect_to root_path
  end

end
