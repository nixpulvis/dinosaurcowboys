class Rank < ActiveRecord::Base
  has_many :users

  validates :name, :presence => true

  def to_s
    self.name
  end
end
