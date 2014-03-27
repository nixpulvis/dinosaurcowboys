# UploadsController
# Controller for the user uploads.
#
# Actions: [index, new, create, destroy]
#
class UploadsController < ApplicationController
  before_action do
    @user = User.find(params[:user_id])
  end

  # GET /users/:user_id/uploads
  # Provide all of the uploads for the given user.
  #
  def index
    @uploads = policy_scope(@user.uploads)
                 .includes(:user)
    authorize @uploads
  end

  # GET /users/:user_id/uploads/new
  # Build an upload and provide the UI to create it.
  #
  def new
    @upload = @user.uploads.build
    authorize @upload
  end

  # POST /users/:user_id/uploads
  # Create an upload for the given user. Uploading the image happens
  # behind the scenes in the Upload model.
  #
  def create
    @upload = @user.uploads.build(upload_params)
    authorize @upload

    respond_to do |format|
      if @upload.save
        format.json { render json: @upload }
        format.html { redirect_to user_uploads_path(@user) }
      else
        format.json { render json: @upload.errors }
        format.json { render :new }
      end
    end
  end

  # DELETE /users/:user_id/uploads/:id
  # Deletes the given user upload.
  #
  def destroy
    @upload = @user.uploads.find(params[:id])
    authorize @upload

    @upload.destroy
    redirect_to user_uploads_path(@user)
  end

  private

  # upload_params: -> Hash
  # Permits the upload fields for assignment.
  #
  def upload_params
    permit = policy(@upload || Upload).permitted_attributes
    params.require(:upload).permit(*permit)
  end
end
