# ShoutPolicy
# Defines the policy for shouts on this site.
#
# The public is not allowed anything.
# Users can read and write shouts, as well as removing (hiding) their own shouts.
# Admins are allowed to toggle visibility for any given shout.
#
class ShoutPolicy < BasePolicy
  class Scope < BaseScope  # rubocop:disable Documentation
    def resolve
      if user.admin?
        scope
      elsif user.try(:rank)
        scope.where(hidden: false)
      else
        Shout.none
      end
    end
  end

  def index?
    user.try(:rank) || super
  end

  def create?
    (user == record.user && user.rank) || super
  end

  def show?
    if record.hidden?
      super
    else
      user.admin? || super
    end
  end

  def hide?
    user == record.user || user.admin? || super
  end

  def destroy?
    false
  end

  def permitted_attributes
    [:shout]
  end
end
