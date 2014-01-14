module UsersHelper

  # has_access: User -> Boolean
  def has_access(user)
    current_user.admin? || current_user == user
  end


end
