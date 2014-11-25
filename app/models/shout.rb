# Shout
# A shout is a chat message submitted by a user within a shout box.
#
class Shout < ActiveRecord::Base
  include Toggleable

  # A user creates a shout, we save this relationship to show who made
  # the shout.
  belongs_to :user

  # A shout must have a shout (text) associated with it!
  validates :shout, presence: true, length: { maximum: 255 }

  # Set the number of shouts to show at any given time.
  paginates_per 50

end
