class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :manage, :all if user.admin?

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
