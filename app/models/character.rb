# Character
# A character is defined by it's name and server. We will then pull
# down information about them from the Blizz API.
#
# Fields we want from Blizz:
# - Class
# - Level
# - Achievement Points
# - Average Equiped iLvL
# - Spec
# - Role
# - Thumbnail URL
# - Guild Name
#
class Character < ActiveRecord::Base
  DestoryError = Class.new(StandardError)

  # A user must own the character.
  belongs_to :user

  # Validate the two fields needed to look up a character.
  validates :name, presence: true, length: { maximum: 12 },
                   uniqueness: { scope: :server }
  validates :server, presence: true
  validates_with CharacterValidator

  before_create :sync

  # Users cannot delete their main.
  before_destroy do
    fail DestoryError, 'Cannot destroy main character' if main?
  end

  # -> String
  # A character is displayed by it's name.
  #
  def to_s
    name.titleize
  end

  def armory_url
    "http://us.battle.net/wow/en/character/#{dashed_server}/#{name}/advanced"
  end

  # -> WoW::Character
  # Returns the result of the wow gems call to the blizz API.
  #
  def api
    fields = [:items, :talents, :guild]
    @api ||= WoW::Character.new(dashed_server, name, fields)
  end

  # -> NA
  # Sync the data from blizz api with our data model.
  #
  # rubocop:disable Metrics/AbcSize
  def sync
    self.klass = api.get('class')
    self.level = api['level']
    self.achievement_points = api['achievementPoints']
    self.average_item_level_equiped = api['items']['averageItemLevelEquipped']
    self.spec = api.get('active_spec')['spec'].try(:[], 'name')
    self.role = api.get('active_spec')['spec'].try(:[], 'role')
    self.thumbnail = api.get('thumbnail')
    self.guild_name = api['guild'].try(:[], 'name')
  end

  private

  def dashed_server
    server.gsub(/ /, '-')
  end
end
