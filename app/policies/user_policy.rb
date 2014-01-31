class UserPolicy < BasePolicy
  class Scope < BaseScope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(id: user.id)
      end
    end
  end

  def show?
    user.id == record.id || super
  end

  def create?
    true
  end

  def update?
    user.id == record.id || super
  end

  def permitted_attributes
    permitted = [:email, :password, :password_confirmation,
      characters_attributes: [:name, :server]]

    if user.admin? || user.rank.try(:>=, "Officer")
      permitted << :rank_id
    end

    if user.admin?
      permitted << :admin
    end

    permitted
  end
end
