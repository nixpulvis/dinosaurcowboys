class Boss < ActiveRecord::Base
  belongs_to :raid

  def self.find_by_param(string)
    where('lower(name) = ?', string.gsub("_", " ")).first
  end

  def to_param
    name.downcase.gsub(" ", "_")
  end
end
