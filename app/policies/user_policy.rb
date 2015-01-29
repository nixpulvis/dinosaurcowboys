# UserPolicy
# Defines the policy for users on this site.
#
# Users are only allowed to update their own record.
#
class UserPolicy < BasePolicy
  class Scope < BaseScope  # rubocop:disable Documentation
    def resolve
      if user.admin?
        scope
      else
        scope.where(id: user.id, hidden: false)
      end
    end
  end

  def show?
    record.id == user.id || record.shown? || super
  end

  def create?
    true
  end

  def update?
    user.id == record.id || super
  end

  def destroy?
    false
  end

  def show_personal_info?
    (record.shown? && user.id == record.id) || user.admin?
  end

  def permitted_attributes
    permitted = [:email, :password, :password_confirmation, :battlenet,
                 avatar_attributes: [:file, :user_id],
                 main_attributes: [:name, :server]]

    permitted << :rank_id if user.admin? || user.rank.try(:>=, 'Officer')
    permitted += [:admin, :raid_moderator, :created_at] if user.admin?
    permitted
  end
end
