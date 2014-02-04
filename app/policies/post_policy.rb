# PostPolicy
# Defines the policy for posts on this site.
#
# Posts permissions are defined by their postable.
#
class PostPolicy < ApplicationPolicy
  def create?
    Pundit.policy(user, record.postable).write? || super
  end

  def show?
    Pundit.policy(user, record.postable).read? || super
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
