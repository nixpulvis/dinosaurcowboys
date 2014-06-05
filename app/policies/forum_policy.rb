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

  def show?
    (user.rank && user.rank.readable_forums.include?(record)) || super
  end

  def destroy?
    false
  end

  def show_topics?
    show?
  end

  def create_topics?
    (user.rank && user.rank.writable_forums.include?(record)) || user.admin?
  end

  def permitted_attributes
    [:name, :public, :row_order, readable_rank_ids: [], writable_rank_ids: []]
  end
end
