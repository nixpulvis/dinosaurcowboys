class ForumsController < ApplicationController
  load_and_authorize_resource

  def index
    @topics = Topic.accessible_by(current_ability).first(8)
  end

  def new
  end

  def create
    if @forum.save
      redirect_to forum_path(@forum)
    else
      render :new
    end
  end

  def show
    @topics = @forum.topics.page(params[:page])
    @topic = Topic.new
    @post  = @topic.posts.build
  end

  def edit
    # TODO
  end

  def update
    # TODO
  end

  def destroy
    # TODO
  end

  private

  def forum_params
    params.require(:forum).permit(:name)
  end

end
