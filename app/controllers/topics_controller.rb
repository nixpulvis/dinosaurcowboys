# TopicsController
# Controller for the Topic model nested in Forum.
#
# Actions: [create, show, edit, update, destroy]
#
class TopicsController < ApplicationController
  before_action only: [:show, :edit, :update, :destroy] do
    forum = Forum.find(params[:forum_id])
    @topic = forum.topics.find(params[:id])
    authorize @topic
  end

  # POST /forum/:forum_id/topics
  # Creates a new topic with the passed in parameters. It then sets
  # the topic's user and it's first post's user to the current user.
  #
  def create
    @forum = Forum.find(params[:forum_id])
    @topic = @forum.topics.build(topic_params)
    @topic.user = current_user && @topic.posts.first.user = current_user
    authorize @topic

    if @topic.save
      redirect_to forum_topic_path(@forum, @topic)
    else
      @topics = policy_scope(@forum.topics)
                  .order(sticky: :desc, updated_at: :desc)
                  .page(params[:page])
      render 'forums/show'
    end
  end

  # GET /forum/:forum_id/topics/:id
  # Provides the topic, and it's posts.
  #
  def show
    impressionist @topic, "Topic view", unique: [:session_hash]
    @posts = Post.for_postable(@topic, params[:page])
    @post  = @topic.posts.build
  end

  # GET /forum/:forum_id/topics/:id/edit
  # Provides the topic for editing.
  #
  def edit
  end

  # PATCH or PUT /forum/:forum_id/topics/:id
  # Allows for updates to the topic's attributes.
  #
  def update
    if @topic.update_attributes(topic_params)
      redirect_to forum_topic_path(@topic.reload.forum, @topic)
    else
      render :edit
    end
  end

  # DELETE /forum/:forum_id/topics/:id
  # Destroys the topic and it's posts.
  #
  def destroy
    @topic.destroy
    redirect_to forum_path(@topic.forum)
  end

  private

  # topic_params: -> Hash
  # Permits the topic fields for assignment.
  #
  def topic_params
    permit = policy(@topic || Topic).permitted_attributes
    params.require(:topic).permit(*permit)
  end
end
