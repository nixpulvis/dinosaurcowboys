# ForumPolicy
# Defines the policy for forums on this site.
#
# Users read and write permissions are defined by their rank.
# Officers are allowed to create, and update forums.
#
class ForumPolicy < BasePolicy
  class Scope < BaseScope  # rubocop:disable Documentation
    def resolve
      if user.admin?
        scope
      else
        user.rank.try(:readable_forums) || Forum.none
      end
    end
  end

  def index?
    user.rank || super
  end

  def create?
    update?
  end

  def update?
    user.rank.try(:>=, 'Officer') || super
  end

  def show?
    read? || super
  end

  def destroy?
    false
  end

  # READ === See the topics, and thier posts.
  def read?
    (user.rank && user.rank.readable_forums.include?(record))
  end

  # WRITE === Make new topics, and post on topics.
  def write?
    (user.rank && user.rank.writable_forums.include?(record))
  end

  def permitted_attributes
    [:name, :public, readable_rank_ids: [], writable_rank_ids: []]
  end
end
