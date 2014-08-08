# BossPolicy
# Defines the policy for bosses on this site.
#
# Permissions of bosses are the same as their raid.
#
class BossPolicy < BasePolicy
  class Scope < BaseScope  # rubocop:disable Documentation
    def resolve
      if user.rank.try(:>=, 'Officer') || user.raid_moderator? || user.admin?
        scope.rank(:row_order)
      else
        scope
          .where(raid_id: Pundit.policy_scope(user, Raid).pluck(:id))
          .where(hidden: false)
          .rank(:row_order)
      end
    end
  end

  def show?
    (record.shown? && Pundit.policy(user, record.raid).show?) ||
      create? || super
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
    Pundit.policy(user, record.raid).show_posts?
  end

  def create_posts?
    Pundit.policy(user, record.raid).create_posts?
  end

  def permitted_attributes
    [:name, :content, :updates, :row_order]
  end
end
