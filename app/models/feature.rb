# Feature
# An feature is a post like class that can be posted with a title,
# and is intended to be very viable and time related.
#
class Feature < ActiveRecord::Base
  include Markdownable

  # An feature must have a title and a body.
  validates :title, presence: true
  validates :body, presence: true
end
