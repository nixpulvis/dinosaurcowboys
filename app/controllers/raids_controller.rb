# RaidsController
# Controller for the Raid model.
#
# Actions: [index, new, create, show, edit, update, toggle, destroy]
#
class RaidsController < ApplicationController
  before_action only: [:show, :edit, :update, :toggle, :destroy] do
    @raid = Raid.find(params[:id])
    authorize @raid
  end

  # GET /raids
  # Provides the raids.
  #
  def index
    @raids = policy_scope(Raid)
               .order(tier: :desc)

    authorize @raids
  end

  # GET /raids/new
  # Builds a raid to create.
  #
  def new
    @raid = Raid.new
    authorize @raid
  end

  # POST /raids
  # Creates a new raid with the passed in parameters.
  # Redisplays the new page when there are errors.
  #
  def create
    @raid = Raid.new(raid_params)
    authorize @raid

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
    @bosses = policy_scope(@raid.bosses).order(:row_order)

    @posts = Post.for_postable(@raid, params[:page])
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

  # PATCH /raids/:id/toggle
  # Hide or show the given raid, setting it's hidden attribute.
  #
  def toggle
    @raid.toggle
    redirect_to :back
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
    params.require(:raid).permit(*policy(@raid || Raid).permitted_attributes)
  end
end
