class TopicsController < ApplicationController

  before_filter do
    @forum = Forum.find(params[:forum_id])
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.forum = @forum

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
    params.require(:topic).permit(:title)
  end

end
