class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Lock it down.
  check_authorization :unless => :devise_controller?

  # Apply strong_parameters filtering before CanCan authorization
  # See https://github.com/ryanb/cancan/issues/571#issuecomment-10753675
  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  # Allowing things like iframes in content of the site requires this.
  # The browser by default shits itself if a response comes back with
  # the same script-like data sent.
  before_filter do
    response.headers['X-XSS-Protection'] = "0"
  end

  # Don't error 500 when people try to access bad things,
  # pretend like it's just not found.
  rescue_from CanCan::AccessDenied do |exception|
    raise ActionController::RoutingError.new("Don't have access")
  end

end
