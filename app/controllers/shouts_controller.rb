# ShoutsController
# Controller for the Shout model. Only defines database
# actions, this controller doesn't render anything.
#
# Actions: [index, create, toggle]
#
class ShoutsController < ApplicationController
  before_action only: [:toggle] do
    @shout = Shout.find(params[:id])
    authorize @shout
  end

  # GET /shouts
  # Provide all of the shouts that the given user can see.
  #
  def index
    @shouts = policy_scope(Shout)
              .order(created_at: :desc)
              .page(params[:page])
    authorize @shouts

    respond_to do |format|
      format.json { render json: @shouts }
    end
  end

  # POST /shouts
  # Create a shout for the given user.
  #
  def create
    @shout = current_user.shouts.build(shout_params)
    authorize @shout

    respond_to do |format|
      if @shout.save
        format.json { render json: @shout }
      else
        format.json { render json: @shout.errors }
      end
    end
  end

  # PATCH /shouts/:id/toggle
  # Hide or show the given shout, setting it's hidden attribute.
  #
  def toggle
    @shout.toggle
    respond_to do |format|
      format.json { render json: @shout }
    end
  end

  private

  # shout_params: -> Hash
  # Permits the shout fields for assignment.
  #
  def shout_params
    @base_params = params
                   .require(:shout)
                   .permit(*policy(@shout || Shout)
                   .permitted_attributes)
    # Extend shout with user's main character and color
    # (We can't do this with .include since 'main' is a helper)
    @base_params['name'] = current_user.main.name
    @base_params['klass'] = current_user.main.klass
    @base_params
  end
end
