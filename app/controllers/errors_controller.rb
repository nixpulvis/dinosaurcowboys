class ErrorsController < ApplicationController

  def not_found
    render '404', layout: :default, status: :not_found
  end

  def unprocessable_entity
    render '422', status: :unprocessable_entity
  end

  def internal_server_error
    render '500', status: :internal_server_error
  end

end
