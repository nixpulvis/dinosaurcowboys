# Character
# A character is defined by it's name and server. We will then pull
# down information about them from the Blizz API.
#
class Character < ActiveRecord::Base
  # A user must own the character.
  belongs_to :user

  # Validate the two fields needed to look up a character.
  validates :name, presence: true, length: { maximum: 12 }
  validates :server, presence: true
  validates_with CharacterValidator

  # Cache API calls.
  attr_accessor :api

  # FIXME: This should be rethought.
  after_save :reconcile

  # Make sure we assign a new main, if there are no
  # other characters, fail.
  before_destroy :reassign

  # -> String
  # A character is displayed by it's name.
  #
  def to_s
    self.name.titleize
  end

  private

  # Sync the data from blizz api with out data model.
  def sync!
    self.api ||= WoW::CharacterProfile.new(self.server, self.name)
    self.update_columns(klass: self.api.lookup(:class), level: self.api[:level])
  end

  # FIXME: This should be thought through more.
  def reconcile
    sync!

    if self.main?
      self.user.characters.where.not(id: self.id).update_all(main: false)
    else
      self.user.characters.first.update_column(:main, true)
    end
  end

  def reassign
    if self.main?
      characters = self.user.characters
      if characters.reject(&:marked_for_destruction?).count <= 1
        self.errors.add(:base, "Cannot destroy only character")
        return false
      else
        characters.where.not(id: self.id).first.update_attribute(:main, true)
      end
    end
  end

end
