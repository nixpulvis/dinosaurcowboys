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
    @post  = @raid.posts.build
  end

  # GET /raids/:id/edit
  # Provides the given raid, and a UI to edit it.
  #
  def edit
  end

  # PATCH or PUT /raids/:id
  # Allows for raids to be updated.
  #
  def update
    if @raid.update_attributes(raid_params)
      redirect_to raid_path(@raid)
    else
      render :edit
    end
  end

  # DELETE /raids/:id
  # Destroys the given raid, and all it's bosses.
  #
  def destroy
    @raid.destroy
    redirect_to raids_path
  end

  private

  # raid_params: -> Hash
  # Permits the raid fields for assignment.
  #
  def raid_params
    params.require(:raid).permit(:name, :tier, :content)
  end

end
