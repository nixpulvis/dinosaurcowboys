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

  # The paperclip banner photo file object itself.
  # TODO: Tweak sizes.
  has_attached_file :banner_photo, styles: { medium: '300x300>',
                                             thumb: '50x50#' }

  # Validate that raids have a name and tier.
  validates :name, presence: true
  validates :tier, numericality: true, allow_nil: true
  validates :banner_photo, presence: true
  validates_attachment_content_type :banner_photo, content_type: /\Aimage\/.*\Z/

  # Setup the routing to be of the form "/raids/name_of_raid".
  # TODO: Maybe make this functionality into a module.
  class << self
    alias_method :_find, :find

    def find(value)
      if value.is_a?(String)
        where('lower(name) = ?', value.gsub('_', ' ')).first
      else
        _find(value)
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
