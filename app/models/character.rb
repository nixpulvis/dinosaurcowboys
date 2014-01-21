# Character
# A character is defined by it's name and server. We will then pull
# down information about them from the Blizz API.
#
# TODO: Blizz API.
#
class Character < ActiveRecord::Base
  # A user must own the character.
  belongs_to :user

  # Validate the two fields needed to look up a character.
  validates :name, presence: true, length: { maximum: 12 }
  validates :server, presence: true
  validates_with CharacterValidator

  # -> String
  # A character is displayed by it's name.
  #
  def to_s
    self.name
  end
end
