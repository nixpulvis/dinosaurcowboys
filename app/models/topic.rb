# Topic
# A topic is a collection of posts on a forum. This is also sometimes
# known as a thread. A user creates a topic and then users post on
# it.
#
class Topic < ActiveRecord::Base
  # Each topic falls under a forum, and inherits it's permissions.
  belongs_to :forum

  # A user creates a topic, we save this relationship to allow that user
  # to delete the topic if they want.
  belongs_to :user

  # All the posts!
  has_many :posts, :as => :postable, :dependent => :destroy

  # Keeps track of views.
  is_impressionable

  # TODO: A topic must have a title, and at least one post.
  validates :title, :presence => true

  # By default order the topics from newest to oldest. So the
  # newest topics show up first.
  default_scope -> { order('updated_at DESC') }

  # Set the number of topics to show per page.
  paginates_per 10

  # Allow topics forms to create posts.
  accepts_nested_attributes_for :posts

  # -> String
  # The title of the topic.
  #
  def to_s
    self.title
  end

  # -> DateTime
  # The most recent update to the posts of this topic.
  #
  def posts_updated_at
    posts.maximum(:updated_at)
  end
end
