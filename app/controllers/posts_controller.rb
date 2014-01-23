class PostsController < ApplicationController
  before_action :load_postable
  load_and_authorize_resource :post, through: :postable

  # POST /postable/:postable_id/posts
  # Creates a post on the postable, as the current user.
  #
  def create
    @post.user = current_user

    if @post.save
      redirect_to postable_path(@post.postable)
    else
      render :new
    end
  end

  # PATCH or PUT /postable/:postable_id/posts/:id
  # Allows for users to update their posts.
  #
  def update
    if @post.update_attributes(post_params)
      redirect_to postable_path(@post.postable)
    else
      render :edit
    end
  end

  # DELETE /postable/:postable_id/posts/:id
  # Destroys the post.
  #
  def destroy
    @post.destroy
    redirect_to postable_path(@post.postable)
  end

  private

  # post_params: -> Hash
  # Permits the post fields for assignment.
  #
  def post_params
    params.require(:post).permit(:body)
  end

  # postable -> (Instance of Model)
  # Returns the postable for this post. For example for
  # /raids/12/posts postable would be the Raid with id 12.
  #
  def postable
    resource, id = request.path.split('/')[1,2]
    resource.singularize.classify.constantize.find(id)
  end

  # load_postable -> (Instance of Model)
  # Loads the postable into an appropriately named instance variable.
  # See postable for the value of this variable.
  #
  def load_postable
    instance_variable_set("@postable", postable)
  end

  # postable_path (Instance of Model) -> String
  # Returns a path to the given model, this allows posts to
  # route without worrying about nesting.
  #
  def postable_path(postable)
    if postable.is_a? Raid
      raid_path(postable)
    elsif postable.is_a? Boss
      raid_boss_path(postable.raid, postable)
    elsif postable.is_a? Topic
      forum_topic_path(postable.forum, postable)
    elsif postable.is_a? Application
      user_application_path(postable.user)
    end
  end

end
