# CharacterPolicy
# Defines the policy for characters on this site.
#
# The public can view characters and the roster.
# Users can create, update, and destroy characters for themselves.
#
class CharacterPolicy < BasePolicy
  class Scope < BaseScope  # rubocop:disable Documentation
    def resolve
      scope
    end
  end

  def create?
    user == record.user || super
  end

  def show?
    true
  end

  def update?
    user == record.user || super
  end

  def promote?
    user == record.user || user.admin?
  end

  def destroy?
    user == record.user || super
  end

  def roster?
    true
  end

  def permitted_attributes
    [:name, :server]
  end
end
