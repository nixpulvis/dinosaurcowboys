# Boss
# A boss is a description of the boss, with comment posts.
# The description should be our guilds strategy which will
# be updated like a wiki to allow up to date information
# located in one place.
#
# TODO: Wiki.
#
class Boss < ActiveRecord::Base
  include Markdownable
  include Postable
  include RankedModel
  include Toggleable

  # A boss is in a raid.
  belongs_to :raid

  # Keeps track of views.
  is_impressionable

  # Validate that raids have a name and tier.
  validates :name, presence: true

  # Custom ordering support.
  ranks :row_order

  # Setup the routing to be of the form "/.../bosses/name_of_boss".
  # TODO: Maybe make this functionality into a module.
  class << self
    alias_method :_find, :find

    def find_by_param(value)
      if value.is_a?(String)
        where('lower(name) = ?', value.gsub('_', ' ')).first
      else
        _find(value)
      end
    end

    alias_method :find, :find_by_param
  end

  def to_param
    name.downcase.gsub(' ', '_')
  end

  def to_s
    name
  end
end
