# FeaturesController
# Controller for features on the website.
#
# Actions: [new, create, edit, update, destroy]
#
class FeaturesController < ApplicationController
  before_action only: [:edit, :update, :destroy] do
    @feature = Feature.find(params[:id])
    authorize @feature
  end

  # GET /features/new
  # Build a new feature to create.
  #
  def new
    @feature = Feature.new
    authorize @feature
  end

  # POST /features
  # Create a new feature with the passed in parameters.
  # Redisplays the new page when there are errors.
  #
  def create
    @feature = Feature.new(feature_params)
    authorize @feature

    if @feature.save
      redirect_to root_path
    else
      render :new
    end
  end

  # GET /features/:id/edit
  # Provides the given feature to be updated.
  #
  def edit
  end

  # PATCH or PUT /features/:id
  # Allows the feature to be updated.
  #
  def update
    if @feature.update_attributes(feature_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  # DELETE /features/:id
  # Destroys the given feature.
  #
  def destroy
    @feature.destroy unless Feature.count <= 1
    redirect_to root_path
  end

  protected

  # feature_params: -> Hash
  # Permits the feature fields for the assignment.
  #
  def feature_params
    params.require(:feature).permit(*policy(@feature || Feature)
                            .permitted_attributes)
  end
end
