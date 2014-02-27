# Forum
# A forum is like a category. Each forum has some permissions and a
# bunch of topics. Topics in a forum inherit their permissions from
# the forum.
#
class Forum < ActiveRecord::Base
  # The forum's topics.
  has_many :topics, dependent: :destroy

  # Accesses are given out on a forum to fourm basis,
  # and grant access to either read / write permissions.
  has_many :read_accesses,  -> { where permission: 'read' },
           class_name: 'Access'
  has_many :write_accesses, -> { where permission: 'write' },
           class_name: 'Access'
  has_many :readable_ranks, through: :read_accesses, source: :rank
  has_many :writable_ranks, through: :write_accesses, source: :rank

  # Allow forum to set it's ranks.
  accepts_nested_attributes_for :readable_ranks, :writable_ranks

  # A forum must have a name.
  validates :name, presence: true

  # -> String
  # Display a forum by it's name.
  #
  def to_s
    name
  end

  # -> Topic
  # The forum's most recently updated topic.
  #
  # FIXME
  #
  def freshest
    topics.select(&:posts_updated_at).max_by(&:posts_updated_at)
  end
end
