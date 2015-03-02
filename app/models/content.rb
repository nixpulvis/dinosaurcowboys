# Content
# Content is a minimal class that can be created with markdown, to
# be used where anonymous content is wanted on the site.
#
class Content < ActiveRecord::Base
  include Markdownable

  # Content must have a label and body.
  validates :label, :body, presence: true

  # Contents label must be unique.
  validates :label, uniqueness: true

  def self.for(label)
    where(label: label).first || new(label: label)
  end
end
