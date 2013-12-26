class BossesController < ApplicationController

  def new
    @raid = Raid.find(params[:raid_id])
    @boss = @raid.bosses.build
  end

  def create
    @raid = Raid.find(params[:raid_id])
    @boss = @raid.bosses.build(boss_params)

    if @boss.save
      redirect_to raid_boss_path(@raid, @boss)
    else
      render :new
    end
  end

  def show
    @raid = Raid.find(params[:raid_id])
    @boss = @raid.bosses.find_by_param(params[:id])
    @posts = @boss.posts
  end

  protected

  def boss_params
    params.require(:boss).permit(:name, :content)
  end

end
