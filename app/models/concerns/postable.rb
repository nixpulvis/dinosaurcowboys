# Postable
# A module to add functionality of something that can be posted
# on, like a topic or an application.
#
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

  # -> Post
  # Returns the post that was created the most recently.
  #
  def last_post
    @last_post ||= posts.order(:created_at).last
  end

  # last_page -> Fixnum
  # Returns the number of the last page of the given postable
  # object.
  #
  def last_page
    posts.page.total_pages
  end
end

# Add path helper to application controller to be in all controllers.
class ApplicationController < ActionController::Base
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

  # postable_post_path Post -> String
  # Returns a path to the given post in it's postable's show action. Posts
  # id are put into their HTML so this will automatically navigate to the
  # post
  #
  def postable_post_path(postable, post)
    postable_path(postable, page: postable.last_page) + "##{post.id}"
  end
  helper_method :postable_post_path
end
