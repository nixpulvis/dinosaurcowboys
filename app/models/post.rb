# Post
# A post is simply some text that has a user, and something it
# was posted on.
#
class Post < ActiveRecord::Base
  include PartyShark::Markdownable

  # A post belongs to what it was posted on, and updating the post updates
  # that model too.
  belongs_to :postable, polymorphic: true, touch: true

  # A user creates a post.
  belongs_to :user

  # A post **must** have a body. Empty posts are not allowed.
  validates :body, presence: true

  # Set the number of posts to show per page.
  paginates_per 10
end
