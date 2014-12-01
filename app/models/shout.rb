# Shout
# A shout is a chat message submitted by a user within a shout box.
#
class Shout < ActiveRecord::Base
  before_save do
    self.message = Sanitize.clean(self.message)
  end

  # A user creates a shout, we save this relationship to show who made
  # the shout.
  belongs_to :user

  # A shout must have convenient information on who made it.
  validates :name, presence: true
  validates :klass, presence: true

  # A shout must have a message associated with it!
  validates :message, presence: true, length: { maximum: 255 }

  # Set the number of shouts to show at any given time.
  paginates_per 25
end
