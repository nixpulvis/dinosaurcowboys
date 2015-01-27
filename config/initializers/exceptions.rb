module ActionDispatch
  class ExceptionWrapper
    @@rescue_responses.merge!('Pundit::NotAuthorizedError' => :forbidden)
  end
end
