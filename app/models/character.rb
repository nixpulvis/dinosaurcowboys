class Character < ActiveRecord::Base
  belongs_to :user

  validates :name, :presence => true
  validates :server, :presence => true

  def to_s
    "#{self.name}-#{self.server}"
  end
end
