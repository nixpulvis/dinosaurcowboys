class Topic < ActiveRecord::Base
  belongs_to :forum
  belongs_to :user
  has_many :posts, :as => :postable, :dependent => :destroy

  validates :title, :presence => true

  paginates_per 10

  accepts_nested_attributes_for :posts

  def to_s
    self.title
  end

  def posts_updated_at
    posts.maximum(:updated_at)
  end
end
