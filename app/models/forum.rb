class Forum < ActiveRecord::Base
  has_many :topics, :dependent => :destroy

  validates :name, :presence => true

  def to_s
    self.name
  end
end
