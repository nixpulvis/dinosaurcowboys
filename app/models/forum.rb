# Forum
# A forum is like a category. Each forum has some permissions and a
# bunch of topics. Topics in a forum inherit their permissions from
# the forum.
#
# TODO: Permissions per rank.
#
class Forum < ActiveRecord::Base
  # The forum's topics.
  has_many :topics, :dependent => :destroy

  # A forum must have a name.
  validates :name, :presence => true

  # -> String
  # Display a forum by it's name.
  #
  def to_s
    self.name
  end

  # -> Topic
  # The forum's most recently updated topic.
  #
  def freshest
    topics.select(&:posts_updated_at).max_by(&:posts_updated_at)
  end
end
