# Post
# A post is simply some text that has a user, and something it
# was posted on.
#
class Post < ActiveRecord::Base
  include Markdownable

  # A post belongs to what it was posted on, and updating the post updates
  # that model too.
  belongs_to :postable, polymorphic: true, touch: true, counter_cache: true

  # A user creates a post.
  belongs_to :user

  # A post **must** have a body. Empty posts are not allowed.
  validates :body, presence: true

  # Set the number of posts to show per page.
  paginates_per 15

  # Postable, Fixnum -> ActiveRecord::Relation
  # Returns a page of posts for the postable.
  #
  def self.for_postable(postable, page)
    postable.posts
      .includes({ user: [:rank, :avatar, :main] }, :postable)
      .order(created_at: :asc)
      .page(page)
  end

  # page -> Fixnum
  # Returns the page of this post.
  #
  # FIXME: This is causing 1+N queries everywhere.
  #
  def page
    position = Post.where('created_at <= ? AND
                           postable_id = ? AND
                           postable_type = ?',
                          created_at,
                          postable.id,
                          postable.class).size
    (position.to_f / Post.default_per_page).ceil
  end
end
