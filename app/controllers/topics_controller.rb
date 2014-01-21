class TopicsController < ApplicationController
  load_and_authorize_resource :forum
  load_and_authorize_resource through: :forum

  # Keep track of views.
  impressionist actions: [:show],
    unique: [:impressionable_type, :impressionable_id, :session_hash]

  # POST /forum/:forum_id/topics
  # Creates a new topic with the passed in parameters. It then sets
  # the topic's user and it's first post's user to the current user.
  #
  def create
    @topic.user = current_user
    @topic.posts.first.user = current_user

    if @topic.save
      redirect_to forum_topic_path(@forum, @topic)
    else
      @topics = @forum.topics.page(params[:page])
      render "forums/show"
    end
  end

  # GET /forum/:forum_id/topics/:id
  # Provides the topic, and it's posts.
  #
  def show
    @posts = @topic.posts.page(params[:page])
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
      redirect_to forum_topic_path(@topic.forum, @topic)
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
    params.require(:topic).permit(:title, posts_attributes: [:body])
  end

end
