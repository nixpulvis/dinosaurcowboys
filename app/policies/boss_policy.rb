# BossPolicy
# Defines the policy for bosses on this site.
#
# Permissions of bosses are the same as their raid.
#
class BossPolicy < BasePolicy
  class Scope < BaseScope  # rubocop:disable Documentation
    def resolve
      if user.admin?
        scope.all
      else
        scope
          .where(raid_id: Pundit.policy_scope(user, Raid).pluck(:id))
          .where(hidden: false)
      end
    end
  end

  def index?
    true
  end

  def show?
    read? || super
  end

  def create?
    user.rank.try(:>=, 'Officer') || user.raid_moderator? || super
  end

  def update?
    create? || super
  end

  def destroy?
    false
  end

  # READ === See the topic, and its posts.
  def read?
    if user.admin?
      true
    else
      record.shown? && Pundit.policy(user, record.raid).read?
    end
  end

  # WRITE === Make a new topic, and post on it.
  def write?
    Pundit.policy(user, record.raid).write?
  end

  def permitted_attributes
    [:name, :content]
  end
end
