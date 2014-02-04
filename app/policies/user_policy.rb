# UserPolicy
# Defines the policy for users on this site.
#
# Users are only allowed to update their own record.
#
class UserPolicy < BasePolicy
  class Scope < BaseScope  # rubocop:disable Documentation
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(id: user.id)
      end
    end
  end

  def show?
    user.id == record.id || super
  end

  def create?
    true
  end

  def update?
    user.id == record.id || super
  end

  def permitted_attributes
    permitted = [:email, :password, :password_confirmation,
                 characters_attributes: [:name, :server]]

    permitted << :rank_id if user.admin? || user.rank.try(:>=, 'Officer')
    permitted << :admin   if user.admin?
  end
end
