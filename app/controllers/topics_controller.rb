class TopicsController < ApplicationController

  before_filter do
    @forum = Forum.find(params[:forum_id])
  end

  def new
    @topic = Topic.new
    @post  = @topic.posts.build
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.user = current_user
    @topic.forum = @forum
    @topic.posts.first.user = current_user

    if @topic.save
      redirect_to forum_topic_path(@forum, @topic)
    else
      render :new
    end
  end

  def show
    @topic = Topic.find(params[:id])
    @posts = @topic.posts.page(params[:page])
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def topic_params
    params.require(:topic).permit(:title, posts_attributes: [:body])
  end

end
