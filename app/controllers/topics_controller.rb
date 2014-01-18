class TopicsController < ApplicationController
  load_and_authorize_resource

  before_filter do
    @forum = Forum.find(params[:forum_id])
  end

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

  def show
    @posts = @topic.posts.page(params[:page])
  end

  def update
    if @topic.update_attributes(topic_params)
      redirect_to forum_topic_path(@topic.forum, @topic)
    else
      render :edit
    end
  end

  def destroy
    @topic.destroy
    redirect_to forum_path(@topic.forum)
  end

  private

  def topic_params
    params.require(:topic).permit(:title, posts_attributes: [:body])
  end

end
