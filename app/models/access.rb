class Access < ActiveRecord::Base
  belongs_to :rank
  belongs_to :forum
end
