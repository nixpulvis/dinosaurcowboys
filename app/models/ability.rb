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

    # Character permissions.
    can :read, Character
    can [:create, :update, :destroy], Character, user_id: user.id

    # Raids / Bosses
    can :read, Raid if user.persisted?
    can :read, Boss if user.persisted?

    can :read, Forum, name: 'General Discussion'

    can :read, Topic, forum: { name: 'General Discussion' }
    can :create, Topic, forum: { name: 'General Discussion' } if user.persisted?
    can :manage, Topic, user_id: user.id

    can :create, Post if user.persisted?
    can :manage, Post, user_id: user.id
  end
end
