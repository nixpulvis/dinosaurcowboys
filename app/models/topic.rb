# Topic
# A topic is a collection of posts on a forum. This is also sometimes
# known as a thread. A user creates a topic and then users post on
# it.
#
class Topic < ActiveRecord::Base
  include Postable

  # A user creates a topic, we save this relationship to allow that user
  # to delete the topic if they want.
  belongs_to :user

  # Each topic falls under a forum, and inherits it's permissions.
  belongs_to :forum

  # Keeps track of views.
  is_impressionable

  # A topic must have a title.
  validates :title, presence: true, length: { maximum: 40 }

  # Set the number of topics to show per page.
  paginates_per 15

  # -> String
  # The title of the topic.
  #
  def to_s
    title
  end
end
