module ApplicationsHelper

  def decide_link(label, user, status)
    link_to(label, decide_user_application_path(user, application: {status: status}),
      method: :patch, confirm: "Are you sure?")
  end

end
