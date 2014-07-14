# RaidPolicy
# Defines the policy for raids on this site.
#
# Anyone with a rank is allowed to read the raids.
# Trials and higher are allowed to comment.
# Officers and Raid moderators are allowed to create and update raids.
#
class RaidPolicy < BasePolicy
  class Scope < BaseScope  # rubocop:disable Documentation
    def resolve
      if user.rank.try(:>=, 'Officer') || user.raid_moderator? || user.admin?
        scope
      else
        scope.where(hidden: false)
      end
    end
  end

  def index?
    user.rank || user.raid_moderator? || super
  end

  def show?
    (user.rank && record.shown?) || create? || super
  end

  def create?
    user.rank.try(:>=, 'Officer') || user.raid_moderator? || super
  end

  def update?
    create? || super
  end

  def toggle?
    create? || super
  end

  def destroy?
    false
  end

  def show_posts?
    show?
  end

  def create_posts?
    user.rank.try(:>=, 'Trial') || user.admin?
  end

  def permitted_attributes
    [:name, :tier, :content]
  end
end
