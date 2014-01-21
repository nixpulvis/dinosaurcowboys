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
  end

  # GET /raids/:raid_id/bosses/:id/edit
  # Provides the given boss, and a UI to edit it.
  #
  def edit
    # TODO: Create view.
  end

  # PATCH or PUT /raids/:raid_id/bosses/:id
  # Allows for bosses to be updated.
  #
  def update
    # TODO: Write this action.
  end

  # DELETE /raids/:raid_id/bosses/:id
  # Destroys the given boss.
  #
  def destroy
    # TODO: Write this action.
  end

  private

  # boss_params: -> Hash
  # Permits the boss fields for assignment.
  #
  def boss_params
    params.require(:boss).permit(:name, :content)
  end

end
