class CharacterPolicy < BasePolicy
  class Scope < BaseScope
    def resolve
      scope.all
    end
  end

  def create?
    user == record.user || super
  end

  def show?
    true
  end

  def update?
    user == record.user || super
  end

  def destroy?
    user == record.user || super
  end

  def roster?
    true
  end

  def permitted_attributes
    [:name, :server, :main]
  end
end
