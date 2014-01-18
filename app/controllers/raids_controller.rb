class RaidsController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def new
  end

  def create
    if @raid.save
      redirect_to @raid
    else
      render :new
    end
  end

  def show
    @posts = @raid.posts.page(params[:page])
  end

  protected

  def raid_params
    params.require(:raid).permit(:name, :tier, :content)
  end

end
