# Rank
# A **user's** rank is defined to be what the guild member's rank is
# equivalent to in-game. This avoids the issue of having ranks like
# "Alt". In this way ranks are assigned to users, not to characters.
#
class Rank < ActiveRecord::Base
  # A rank has a bunch of users of that rank.
  has_many :users

  # Accesses are given out on a forum to fourm basis,
  # and grant access to either read / write permissions.
  has_many :read_accesses,  -> { where permission: "read" },  class_name: 'Access'
  has_many :write_accesses, -> { where permission: "write" }, class_name: 'Access'
  has_many :readable_forums, through: :read_accesses, source: :forum
  has_many :writable_forums, through: :write_accesses, source: :forum

  # A rank is defined by it's name.
  validates :name, :presence => true

  # -> String
  # Display ranks by their names.
  #
  def to_s
    self.name
  end
end
