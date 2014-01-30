class ApplicationPolicy < BasePolicy
  class Scope < BaseScope
    def resolve
      if user.rank.try(:>=, "Raider") || user.admin?
        scope.all
      else
        scope.where(user: user)
      end
    end
  end

  def index?
    user.rank.try(:>=, "Raider") || super
  end

  def create?
    user == record.user || super
  end

  def show?
    user == record.user || user.rank.try(:>=, "Raider") || super
  end

  def update?
    user == record.user || super
  end

  def decide?
    user.rank.try(:>=, "Officer")
  end

end
