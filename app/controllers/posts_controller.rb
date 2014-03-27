# PostsController
# Controller for the polymorphic Post model. Only defines database
# actions, this controller doesn't render anything.
#
# Actions: [create, update, destroy]
#
class PostsController < ApplicationController
  before_action only: [:update, :destroy] do
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

    @post.save
    redirect_to postable_post_path(postable, @post)
  end

  # PATCH or PUT /postable/:postable_id/posts/:id
  # Allows for users to update their posts. Redirecting to the
  # postable on the same page as it was on.
  #
  def update
    @post.update_attributes(post_params)
    redirect_to postable_post_path(postable, @post)
  end

  # DELETE /postable/:postable_id/posts/:id
  # Destroys the post.
  #
  def destroy
    @post.destroy
    scope = postable.posts.page(params[:page])
    if scope.empty?
      response_params = { page: scope.current_page - 1 }
    else
      response_params = { page: scope.current_page }
    end
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
end
