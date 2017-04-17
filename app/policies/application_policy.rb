# ApplicationPolicy
# Defines the policy for applications on this site.
#
# The public is not allowed anything.
# Applicants are allowed to show, comment, and update their own applications.
# Raiders are allowed to show and comment on applicants.
# Officers are allowed to decide in addition to Raider permissions.
#
class ApplicationPolicy < BasePolicy
  class Scope < BaseScope  # rubocop:disable Documentation
    def resolve
      if user.admin?
        scope
      elsif user.rank.try(:>=, 'Raider')
        scope.where(hidden: false)
      else
        scope.where(user: user, hidden: false)
      end
    end
  end

  def index?
    user.rank.try(:>=, 'Raider') || super
  end

  def create?
    user == record.user || super
  end

  def show?
    if record.hidden?
      super
    else
      user == record.user || user.rank.try(:>=, 'Raider') || super
    end
  end

  def update?
    user == record.user || super
  end

  def destroy?
    false
  end

  def decide?
    user.rank.try(:>=, 'Officer') || user.admin?
  end

  def show_posts?
    user == record.user || user.rank.try(:>=, 'Raider') || user.admin?
  end

  def create_posts?
    show_posts?
  end

  def permitted_attributes
    permitted = [:name, :age, :gender, :battlenet, :logs, :computer, :ui_screenshot,
                 :raiding_history, :guild_history, :leadership, :playstyle,
                 :why, :referer, :animal, :additional]

    permitted << :status if decide?
    permitted
  end
end
