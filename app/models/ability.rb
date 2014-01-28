class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    ### Admin Permissions

    # An admin can access literally everything.
    can :manage, :all if user.admin?


    ### Page Permissions.

    # Everyone can access the charter page.
    can :charter, :page
    # Everyone can access the home page.
    can :home, :page
    # Everyone can access the logs page.
    can :logs, :page
    # Everyone can access the recruitment page.
    can :recruitment, :page
    # Everyone can access the apply page.
    can :apply, :page


    ### User Permissions

    # Anyone can create a user.
    can [:create, :read], User
    # People logged in as a user can update themselves.
    can :update, User, id: user.id


    ### User Applications Permissions

    # A user can create, and access an application for themselves.
    can [:create, :read, :comment, :update], Application, user_id: user.id

    # Raiders and above can read and comment on anyones application.
    if user.rank.try(:>=, "Raider")
      can [:read, :comment], Application

      # GMs and Officers can decide on anyones applications.
      if user.rank >= "Officer"
        can [:decide], Application
      end
    end

    ### User Character Permissions

    # Anyone can read a users character.
    can :read, Character
    # Users can access their own characters.
    can [:create, :update, :destroy], Character, user_id: user.id


    ### Raid / Boss Permissions

    # Trials and higher have access to read and comment.
    if user.rank.try(:>=, "Trial")
      can [:read, :comment], Raid
      can [:read, :comment], Boss
    end

    if user.rank.try(:>=, "Officer")
      can [:create, :update, :destroy], Raid
      can [:create, :update, :destroy], Boss
    end


    ### Forum Permissions

    # Only users with ranks are even considered when authorizing.
    if user.rank
      # Pull read accessible forum ids from the users rank.
      can :read, Forum, id: user.rank.readable_forums.pluck(:id)
      # Pull write accessible forum ids from the users rank.
      can :comment, Forum, id: user.rank.writable_forums.pluck(:id)
    end


    ### Forum Topic Permissions

    # Only users with ranks are even considered when authorizing.
    if user.rank
      # Pull read accessible topics by ids of readable forums from the users
      # rank.
      can :read, Topic, forum_id: user.rank.readable_forums.pluck(:id)
      # A user can create a topic, and comment on topics in a forum if they
      # have write access to the forum based on their rank.
      can [:create, :comment], Topic, forum_id: user.rank.writable_forums.pluck(:id)
      # A user can always update or destroy their own topics.
      can [:update, :destroy], Topic, user_id: user.id
    end

    ### Post Permissions

    # Build a hash of postable type to postable ids, where the ids are
    # ids of entries of the type of postable that this user can read.
    postable_read_ids = {
      "Raid" => Raid.accessible_by(self, :read).pluck(:id),
      "Boss" => Boss.accessible_by(self, :read).pluck(:id),
      "Topic" => Topic.accessible_by(self, :read).pluck(:id),
      "Application" => Application.accessible_by(self, :read).pluck(:id),
    }

    # Build a hash of postable type to postable ids, where the ids are
    # ids of entries of the type of postable that this user can comment.
    postable_comment_ids = {
      "Raid" => Raid.accessible_by(self, :comment).pluck(:id),
      "Boss" => Boss.accessible_by(self, :comment).pluck(:id),
      "Topic" => Topic.accessible_by(self, :comment).pluck(:id),
      "Application" => Application.accessible_by(self, :comment).pluck(:id),
    }

    # Iterate over the readable hash, allowing this user to read all the ids.
    postable_read_ids.each do |type, ids|
      can :read, Post, postable_id: ids, postable_type: type
    end

    # Iterate over the commentable hash, allowing this user comment on
    # postables he/she has access to.
    postable_comment_ids.each do |type, ids|
      can :create, Post, postable_id: ids, postable_type: type
    end

    # A user can access his/her own posts.
    can [:update, :destroy], Post, user_id: user.id
  end
end
