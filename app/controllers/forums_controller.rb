class ForumsController < ApplicationController

  def index
    @forums = Forum.all
    @topics = Topic.first(5)
  end

  def new
    @forum = Forum.new
  end

  def create
    @forum = Forum.new(forum_params)

    if @forum.save
      redirect_to forum_path(@forum)
    else
      render :new
    end
  end

  def show
    @forum = Forum.find(params[:id])
    @topics = @forum.topics.page(params[:page])
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def forum_params
    params.require(:forum).permit(:name)
  end

end
