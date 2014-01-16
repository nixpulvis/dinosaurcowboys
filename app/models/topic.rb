class Topic < ActiveRecord::Base
  belongs_to :forum
  has_many :posts, :as => :postable, :dependent => :destroy

  validates :title, :presence => true

  paginates_per 10

  def to_s
    self.title
  end
end
