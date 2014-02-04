# Access
# Join model for ranks and forums, allow forums to have ranks
# with defined permissions.
#
class Access < ActiveRecord::Base
  belongs_to :rank
  belongs_to :forum
end
