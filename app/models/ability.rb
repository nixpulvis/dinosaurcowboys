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
    can [:read, :update, :destroy], User, id: user.id

    can :read, Forum, name: "General Discussion"

    Forum.accessible_by(self).each do |forum|
      can :read, Topic, forum_id: forum.id
      can :create, Topic, forum_id: forum.id if user.persisted?
      can [:update, :destroy], Topic, forum_id: forum.id, user_id: user.id
    end

    can :create, Post if user.persisted?
    can [:update, :destroy], Post, user_id: user.id

  end
end
