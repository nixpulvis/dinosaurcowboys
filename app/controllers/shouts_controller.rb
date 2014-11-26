# ShoutsController
# Controller for the Shout model. Only defines database
# actions, this controller doesn't render anything.
#
# Actions: [index, create, toggle]
#
class ShoutsController < ApplicationController
  before_action do
    @user = User.find(params[:user_id])
  end

  # GET /users/:user_id/shouts
  # Provide all of the shouts that the given user can see.
  #
  def index
    @shouts = policy_scope(Shout)
              .includes(:user)
              .order(created_at: :desc)
              .page(params[:page])
    authorize @shouts

    respond_to do |format|
      format.json { render json: @shouts }
    end
  end

  # POST /users/:user_id/shouts
  # Create a shout for the given user.
  #
  def create
    @shout = @user.shouts.build(shout_params)
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
    params.require(:shout).permit(*policy(@shout || Shout).permitted_attributes)
  end
end
