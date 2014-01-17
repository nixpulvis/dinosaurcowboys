class Forum < ActiveRecord::Base
  has_many :topics, :dependent => :destroy

  validates :name, :presence => true

  def freshest
    topics.select(&:posts_updated_at).max_by(&:posts_updated_at)
  end

  def to_s
    self.name
  end
end
