class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    # Fear the admin.
    can :manage, :all if user.admin?

    # Page permissions.
    can :charter, :page
    can :home, :page
    can :logs, :page
    can :recruitment, :page

    # User permissions.
    can :create, User
    can [:read, :update], User, id: user.id

    # Character permissions.
    can :read, Character
    can [:create, :update, :destroy], Character, user_id: user.id

    # Raids / Bosses
    # FIXME: Only allow "some" ranks to see/comment this.
    can :read, Raid if user.persisted?
    can :read, Boss if user.persisted?
    can :comment, Raid if user.persisted?
    can :comment, Boss if user.persisted?

    # Forum access.
    if user.persisted? && user.rank
      can :read,    Forum, id: user.rank.readable_forums.pluck(:id)
      can :comment, Forum, id: user.rank.writable_forums.pluck(:id)
    else
      can :read, Forum, public: true
    end

    forum_read_ids    = Forum.accessible_by(self, :read).pluck(:id)
    forum_comment_ids = Forum.accessible_by(self, :comment).pluck(:id)
    can :read,    Topic, forum_id: forum_read_ids
    can :comment, Topic, forum_id: forum_comment_ids if user.persisted?
    if user.persisted?
      can :create, Topic do |topic|
        forum_comment_ids.include?(topic.forum_id)
      end
    end
    can :manage, Topic, user_id: user.id

    postable_read_ids = {
      "Raid"  => Raid.accessible_by(self, :read).pluck(:id),
      "Boss"  => Boss.accessible_by(self, :read).pluck(:id),
      "Topic" => Topic.accessible_by(self, :read).pluck(:id),
    }
    postable_read_ids.each do |type, ids|
      can :read, Post, postable_id: ids, postable_type: type
    end
    postable_comment_ids = {
      "Raid"  => Raid.accessible_by(self, :comment).pluck(:id),
      "Boss"  => Boss.accessible_by(self, :comment).pluck(:id),
      "Topic" => Topic.accessible_by(self, :comment).pluck(:id),
    }
    postable_comment_ids.each do |type, ids|
      if user.persisted?
        can :create, Post do |post|
          ids.include?(post.postable_id) &&
          type == post.postable_type
        end
      end
    end
    can :manage, Post, user_id: user.id
  end
end
