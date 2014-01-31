class RaidPolicy < BasePolicy
  class Scope < BaseScope
    def resolve
      if Pundit.policy(user, Raid).read? || user.admin?
        scope.all
      else
        scope.none
      end
    end
  end

  def index?
    read? || super
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
    true
  end

  # WRITE === Make a new topic, and post on it.
  def write?
    user.rank.try(:>=, "Trial")
  end

  def permitted_attributes
    [:name, :tier, :content]
  end
end
