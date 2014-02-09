module Postable
  extend ActiveSupport::Concern

  included do
    # All the posts!
    has_many :posts, as: :postable, dependent: :destroy

    # Allow topics forms to create posts.
    accepts_nested_attributes_for :posts
  end

  # -> DateTime
  # The most recent update to the posts of this topic.
  #
  def posts_updated_at
    posts.maximum(:updated_at)
  end

  module ClassMethods
  end

end

class ApplicationController
  # postable_path (Instance of Model) -> String
  # Returns a path to the given model, this allows posts to
  # route without worrying about nesting.
  #
  def postable_path(postable, options = {})
    if postable.is_a? Raid
      raid_path(postable, options)
    elsif postable.is_a? Boss
      raid_boss_path(postable.raid, postable, options)
    elsif postable.is_a? Topic
      forum_topic_path(postable.forum, postable, options)
    elsif postable.is_a? Application
      user_application_path(postable.user, options)
    end
  end
  helper_method :postable_path
end