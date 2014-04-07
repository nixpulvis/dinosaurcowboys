# TopicPolicy
# Defines the policy for topics on this site.
#
# Topics policies are defined by their forum.
#
class TopicPolicy < BasePolicy
  class Scope < BaseScope  # rubocop:disable Documentation
    def resolve
      scope.where(forum_id: Pundit.policy_scope(user, Forum).pluck(:id))
    end
  end

  def create?
    Pundit.policy(user, record.forum).create_topics? || super
  end

  def show?
    Pundit.policy(user, record.forum).show? || super
  end

  def update?
    (show? && user == record.user) || super
  end

  def destroy?
    (show? && user == record.user) || super
  end

  def stick?
    user.rank.try(:>=, 'Officer') || user.admin?
  end

  def show_posts?
    show?
  end

  def create_posts?
    create?
  end

  def permitted_attributes
    permitted = [:title, posts_attributes: [:body]]

    permitted += [:sticky, :forum_id] if user.admin?
    permitted
  end
end
