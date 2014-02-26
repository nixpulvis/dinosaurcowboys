# BossPolicy
# Defines the policy for bosses on this site.
#
# Permissions of bosses are the same as their raid.
#
class BossPolicy < BasePolicy
  class Scope < BaseScope  # rubocop:disable Documentation
    def resolve
      scope.where(raid_id: Pundit.policy_scope(user, Raid).pluck(:id))
    end
  end

  def show?
    read? || super
  end

  def create?
    user.rank.try(:>=, 'Officer') || super
  end

  def update?
    create? || super
  end

  def destroy?
    false
  end

  # READ === See the topic, and its posts.
  def read?
    Pundit.policy(user, record.raid).read?
  end

  # WRITE === Make a new topic, and post on it.
  def write?
    Pundit.policy(user, record.raid).write?
  end

  def permitted_attributes
    [:name, :content]
  end
end
