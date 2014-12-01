# ShoutPolicy
# Defines the policy for shouts on this site.
#
# The public is not allowed anything.
# Users can read + write shouts, as well as removing (hiding) their own shouts.
# Admins are allowed to toggle visibility for any given shout.
#
class ShoutPolicy < BasePolicy
  class Scope < BaseScope  # rubocop:disable Documentation
    def resolve
      scope
    end
  end

  def index?
    true
  end

  def create?
    (user == record.user && user.rank) || super
  end

  def destroy?
    user == record.user || super
  end

  def permitted_attributes
    [:message]
  end
end
