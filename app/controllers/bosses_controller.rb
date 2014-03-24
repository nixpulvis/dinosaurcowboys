# BossesController
# Controller for the Boss model nested in a Raid.
#
# Actions: [new, create, show, edit, update, destroy]
#
class BossesController < ApplicationController
  before_filter only: [:show, :edit, :update, :destroy] do
    raid = Raid.find(params[:raid_id])
    @boss = raid.bosses.find_by_param(params[:id])

    authorize @boss
  end

  # GET /raids/:raid_id/bosses/new
  # Build a boss to create.
  #
  def new
    raid = Raid.find(params[:raid_id])
    @boss = raid.bosses.build
    authorize @boss
  end

  # POST /raids/:raid_id/bosses
  # Creates a new boss with the passed in parameters.
  #
  def create
    raid = Raid.find(params[:raid_id])
    @boss = raid.bosses.build(boss_params)
    authorize @boss

    if @boss.save
      redirect_to raid_boss_path(@boss.raid, @boss)
    else
      render :new
    end
  end

  # GET /raids/:raid_id/bosses/:id
  # Provides the given boss, raid, and the bosses posts.
  #
  def show
    @posts = Post.for_postable(@boss, params[:page])
    @post  = @boss.posts.build
  end

  # GET /raids/:raid_id/bosses/:id/edit
  # Provides the given boss, and a UI to edit it.
  #
  def edit
  end

  # PATCH or PUT /raids/:raid_id/bosses/:id
  # Allows for bosses to be updated.
  #
  def update
    if @boss.update_attributes(boss_params)
      redirect_to raid_boss_path(@boss.raid, @boss)
    else
      render :edit
    end
  end

  # DELETE /raids/:raid_id/bosses/:id
  # Destroys the given boss.
  #
  def destroy
    @boss.destroy
    redirect_to raid_path(@boss.raid)
  end

  private

  # boss_params: -> Hash
  # Permits the boss fields for assignment.
  #
  def boss_params
    params.require(:boss).permit(*policy(@boss || Boss).permitted_attributes)
  end
end
