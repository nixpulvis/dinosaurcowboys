class Raid < ActiveRecord::Base
  include PartyShark::Markdownable

  has_many :bosses, :dependent => :destroy
  has_many :posts, :as => :postable, :dependent => :destroy

  class << self
    def find_by_param(string)
      where('lower(name) = ?', string.gsub("_", " ")).first
    end
    alias_method :find, :find_by_param

    def find_by_param!(string)
      find_by_param(string).tap do |obj|
        raise ActiveRecord::RecordNotFound unless obj
      end
    end
  end

  def to_param
    name.downcase.gsub(" ", "_")
  end
end
