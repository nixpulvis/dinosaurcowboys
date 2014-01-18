class BossesController < ApplicationController
  load_and_authorize_resource :raid
  load_and_authorize_resource :boss, :through => :raid, :find_by => :param, :id_param => :id

  def new
  end

  def create
    if @boss.save
      redirect_to raid_boss_path(@raid, @boss)
    else
      render :new
    end
  end

  def show
    @posts = @boss.posts.page(params[:page])
  end

  protected

  def boss_params
    params.require(:boss).permit(:name, :content)
  end

end
