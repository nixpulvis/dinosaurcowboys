class Boss < ActiveRecord::Base
  include PartyShark::Markdownable

  belongs_to :raid
  has_many :posts, :as => :postable, :dependent => :destroy

  class << self
    def find_by_param(string)
      where('lower(name) = ?', string.gsub("_", " ")).first
    end
    alias_method :find, :find_by_param
  end

  def to_param
    name.downcase.gsub(" ", "_")
  end
end
