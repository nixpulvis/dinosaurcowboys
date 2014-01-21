# Rank
# A **user's** rank is defined to be what the guild member's rank is
# equivalent to in-game. This avoids the issue of having ranks like
# "Alt". In this way ranks are assigned to users, not to characters.
#
class Rank < ActiveRecord::Base
  # A rank has a bunch of users of that rank.
  has_many :users

  # A rank is defined by it's name.
  validates :name, :presence => true

  # -> String
  # Display ranks by their names.
  #
  def to_s
    self.name
  end
end
