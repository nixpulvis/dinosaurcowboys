class RaidsController < ApplicationController
  load_and_authorize_resource

  # GET /raids
  # Provides the raids.
  #
  def index
  end

  # GET /raids/new
  # Builds a raid to create.
  #
  def new
  end

  # POST /raids
  # Creates a new raid with the passed in parameters.
  # Redisplays the new page when there are errors.
  #
  def create
    if @raid.save
      redirect_to @raid
    else
      render :new
    end
  end

  # GET /raids/:id
  # Provides the given raid, and it's posts.
  #
  def show
    @posts = @raid.posts.page(params[:page])
  end

  # GET /raids/:id/edit
  # Provides the given raid, and a UI to edit it.
  #
  def edit
    # TODO: Create view.
  end

  # PATCH or PUT /raids/:id
  # Allows for raids to be updated.
  #
  def update
    # TODO: Write this action.
  end

  # DELETE /raids/:id
  # Destroys the given raid, and all it's bosses.
  #
  def destroy
    # TODO: Write this action.
  end

  private

  # raid_params: -> Hash
  # Permits the raid fields for assignment.
  #
  def raid_params
    params.require(:raid).permit(:name, :tier, :content)
  end

end
