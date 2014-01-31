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
    user.rank.try(:>=, "Officer") || user.admin?
  end

  # READ === See the topic, and its posts.
  def read?
    user == record.user || user.rank.try(:>=, "Raider") || super
  end

  # WRITE === Make a new topic, and post on it.
  def write?
    read?
  end

  def permitted_attributes
    permit = [:name, :age, :gender, :battlenet, :logs, :computer,
      :raiding_history, :guild_history, :leadership, :playstyle, :why,
      :referer, :animal, :additional]

    if decide?
      permit << :status
    end

    permit
  end
end
