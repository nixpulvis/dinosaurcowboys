# Raid
# A raid is a collection of bosses with it's own information.
# It acts a bit like a forum post, where the OP is more wiki
# style allowing for updated information to be located in one
# place.
#
# TODO: Wiki.
#
class Raid < ActiveRecord::Base
  include Markdownable
  include Postable
  include Toggleable

  # As we all know, there are bosses in raids.
  has_many :bosses, dependent: :destroy

  # Validate that raids have a name and tier.
  validates :name, presence: true
  validates :tier, numericality: true, allow_nil: true

  # Setup the routing to be of the form "/raids/name_of_raid".
  # TODO: Maybe make this functionality into a module.
  class << self
    def find_by_param(string)
      where('lower(name) = ?', string.gsub('_', ' ')).first
    end
    alias_method :find, :find_by_param

    def find_by_param!(string)
      find_by_param(string).tap do |obj|
        fail ActiveRecord::RecordNotFound unless obj
      end
    end
  end

  def to_param
    name.downcase.gsub(' ', '_')
  end

  def to_s
    name
  end
end
