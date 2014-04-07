# PostPolicy
# Defines the policy for posts on this site.
#
# Posts permissions are defined by their postable.
#
class PostPolicy < BasePolicy
  class Scope < BaseScope  # rubocop:disable Documentation
    def resolve
      scope
        .includes(:user, :postable)
        .select { |p| Pundit.policy(user, p).show? }
    end
  end

  def create?
    Pundit.policy(user, record.postable).create_posts? || super
  end

  def show?
    Pundit.policy(user, record.postable).show_posts? || super
  end

  def update?
    user == record.user || super
  end

  def destroy?
    user == record.user || super
  end

  def permitted_attributes
    [:body]
  end
end
