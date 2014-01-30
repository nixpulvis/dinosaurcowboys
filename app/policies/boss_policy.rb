class BossPolicy < BasePolicy
  class Scope < BaseScope
    def resolve
      scope.where(raid_id: Pundit.policy_scope(user, Raid).pluck(:id))
    end
  end

  def show?
    read? || super
  end

  def create?
    user.rank.try(:>=, "Officer") || super
  end

  def update?
    create? || super
  end

  # READ === See the topic, and its posts.
  def read?
    Pundit.policy(user, record.raid).read?
  end

  # WRITE === Make a new topic, and post on it.
  def write?
    read?
  end

  def permitted_attributes
    [:name, :content]
  end
end
