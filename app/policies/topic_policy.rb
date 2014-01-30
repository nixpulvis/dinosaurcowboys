class TopicPolicy < BasePolicy
  class Scope < BaseScope
    def resolve
      scope.where(forum_id: Pundit.policy_scope(user, Forum).pluck(:id))
    end
  end

  def create?
    write? || super
  end

  def show?
    read? || super
  end

  def update?
    user == record.user || super
  end

  def destroy?
    user == record.user || super
  end

  # READ === See the topic, and its posts.
  def read?
    Pundit.policy(user, record.forum).read?
  end

  # WRITE === Make a new topic, and post on it.
  def write?
    Pundit.policy(user, record.forum).write?
  end

  def permitted_attributes
    [:title, posts_attributes: [:body]]
  end
end
