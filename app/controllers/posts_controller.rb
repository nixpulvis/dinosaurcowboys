# PostsController
# Controller for the polymorphic Post model. Only defines database
# actions, this controller doesn't render anything.
#
# Actions: [create, update, destroy]
#
class PostsController < ApplicationController
  before_filter only: [:update, :destroy] do
    @post = postable.posts.find(params[:id])
    authorize @post
  end

  # POST /postable/:postable_id/posts
  # Creates a post on the postable, as the current user. Redirecting
  # to the last page, because the new post should always be last.
  #
  def create
    @post = postable.posts.build(post_params)
    @post.user = current_user
    authorize @post

    response_params = { page: last_page(postable) }

    @post.save
    redirect_to postable_path(postable, response_params)
  end

  # PATCH or PUT /postable/:postable_id/posts/:id
  # Allows for users to update their posts. Redirecting to the
  # postable on the same page as it was on.
  #
  def update
    response_params = { page: params[:page].blank? ? 1 : params[:page] }

    @post.update_attributes(post_params)
    redirect_to postable_path(postable, response_params)
  end

  # DELETE /postable/:postable_id/posts/:id
  # Destroys the post.
  #
  def destroy
    response_params = { page: params[:page].blank? ? 1 : params[:page] }

    @post.destroy
    redirect_to postable_path(postable, response_params)
  end

  private

  # post_params: -> Hash
  # Permits the post fields for assignment.
  #
  def post_params
    params.require(:post).permit(*policy(@post || Post).permitted_attributes)
  end

  # postable -> (Instance of Model)
  # Returns the postable for this post. For example for
  # /raids/12/posts postable would be the Raid with id 12.
  #
  def postable
    if @postable
      @postable
    else
      resource, id = request.path.split('/')[1, 2]
      @postable = resource.singularize.classify.constantize.find(id)
    end
  end

  # last_page Postable -> Fixnum
  # Returns the number of the last page of the given postable
  # object.
  #
  def last_page(postable)
    postable.posts.page.total_pages
  end

  # postable_path (Instance of Model) -> String
  # Returns a path to the given model, this allows posts to
  # route without worrying about nesting.
  #
  def postable_path(postable, options = {})
    if postable.is_a? Raid
      raid_path(postable, options)
    elsif postable.is_a? Boss
      raid_boss_path(postable.raid, postable, options)
    elsif postable.is_a? Topic
      forum_topic_path(postable.forum, postable, options)
    elsif postable.is_a? Application
      user_application_path(postable.user, options)
    end
  end
end
