class RaidPolicy < BasePolicy
  class Scope < BaseScope
    def resolve
      if user.rank.try(:>=, "Trial") || user.admin?
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
    user.rank.try(:>=, "Trial")
  end

  # WRITE === Make a new topic, and post on it.
  def write?
    read?
  end

  def permitted_attributes
    [:name, :tier, :content]
  end
end
