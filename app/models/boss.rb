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

  # A boss is in a raid.
  belongs_to :raid

  # Validate that raids have a name and tier.
  validates :name, presence: true

  # Setup the routing to be of the form "/.../bosses/name_of_boss".
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
