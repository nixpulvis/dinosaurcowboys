# ApplicationsHelper
# View helpers specific to applications.
#
module ApplicationsHelper
  # String, User, Symbol
  # Returns a link that submits a form to update the status of an
  # application. The label is the string displayed, and the status
  # must be one of Application::STATES.
  #
  def decide_link(label, user, status)
    path = decide_user_application_path(user, application: { status: status })
    link_to(label, path, class: "status #{status}", method: :patch, data: { confirm: 'Are you sure?' })
  end
end
