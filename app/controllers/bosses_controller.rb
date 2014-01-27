class BossesController < ApplicationController
  load_and_authorize_resource :raid
  load_and_authorize_resource through: :raid, find_by: :param

  # GET /raids/:raid_id/bosses/new
  # Build a boss to create.
  #
  def new
  end

  # POST /raids/:raid_id/bosses
  # Creates a new boss with the passed in parameters.
  #
  def create
    if @boss.save
      redirect_to raid_boss_path(@raid, @boss)
    else
      render :new
    end
  end

  # GET /raids/:raid_id/bosses/:id
  # Provides the given boss, raid, and the bosses posts.
  #
  def show
    @posts = @boss.posts.page(params[:page])
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
      redirect_to raid_boss_path(@raid, @boss)
    else
      render :edit
    end
  end

  # DELETE /raids/:raid_id/bosses/:id
  # Destroys the given boss.
  #
  def destroy
    @boss.destroy
    redirect_to raid_path(@raid)
  end

  private

  # boss_params: -> Hash
  # Permits the boss fields for assignment.
  #
  def boss_params
    params.require(:boss).permit(:name, :content)
  end

end
