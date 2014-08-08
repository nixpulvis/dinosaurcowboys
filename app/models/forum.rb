# Forum
# A forum is like a category. Each forum has some permissions and a
# bunch of topics. Topics in a forum inherit their permissions from
# the forum.
#
class Forum < ActiveRecord::Base
  include RankedModel

  # The forum's topics.
  has_many :topics, dependent: :destroy

  # Accesses are given out on a forum to fourm basis,
  # and grant access to either read / write permissions.
  has_many :read_accesses,  -> { where permission: 'read' },
           class_name: 'Access', dependent: :destroy
  has_many :write_accesses, -> { where permission: 'write' },
           class_name: 'Access', dependent: :destroy
  has_many :readable_ranks, through: :read_accesses, source: :rank
  has_many :writable_ranks, through: :write_accesses, source: :rank

  # Allow forum to set it's ranks.
  accepts_nested_attributes_for :readable_ranks, :writable_ranks

  # A forum must have a name.
  validates :name, presence: true

  # Custom ordering support.
  ranks :row_order

  # New forums should be last in the row order.
  after_initialize do
    self.row_order = Forum.maximum(:row_order) + 1 unless self.persisted?
  end

  # -> String
  # Display a forum by it's name.
  #
  def to_s
    name
  end

  # -> Topic
  # Return the topic in this forum with the most recent post.
  #
  def freshest_topic
    topics.select(&:posts_updated_at).max_by(&:posts_updated_at)
  end
end
