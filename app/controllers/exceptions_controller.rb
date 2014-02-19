# ExceptionsController
# This controller handles the errors of the application.
#
class ExceptionsController < ApplicationController
  layout 'application'

  def show
    exception = env['action_dispatch.exception']
    class_name = exception.class.name

    @code = ActionDispatch::ExceptionWrapper.new(env, exception).status_code
    @status = ActionDispatch::ExceptionWrapper.rescue_responses[class_name]

    respond_to do |format|
      format.html { render @status, status: @code, layout: !request.xhr? }
      format.json do
        render json: { code: @code, status: @status }, status: @code
      end
    end
  end
end
