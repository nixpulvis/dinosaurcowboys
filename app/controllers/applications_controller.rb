class ApplicationsController < ApplicationController
  load_and_authorize_resource :user
  load_and_authorize_resource :application, through: :user, singleton: true

  # GET /applications
  # All of the applications.
  #
  def index
  end

  # GET /applications/new
  # Build an application to create.
  #
  def new

  end

  # POST /applications
  # Creates a new application with the passed in parameters.
  #
  def create
    if @application.save
      redirect_to user_application_path(@user, @application)
    else
      render :new
    end
  end

  # GET /applications/:id
  # Provides the given application.
  #
  def show
    @posts = @application.posts.page(params[:page])
    @post = @application.posts.build
  end

  # GET /applications/:id/edit
  # Provides the given application, and a UI to edit it.
  #
  def edit
  end

  # PATCH or PUT /applications/:id
  # Allows for applications to be updated.
  #
  def update
    if @application.update_attributes(application_params)
      redirect_to user_application_path(@user, @application)
    else
      render :edit
    end
  end

  # DELETE /applications/:id
  # Destroys the given application.
  #
  def destroy
    @application.destroy
    redirect_to root_path
  end

  private

  # boss_params: -> Hash
  # Permits the application fields for assignment.
  #
  def application_params
    params.require(:application).permit(:name, :age, :gender, :battlenet,
      :logs, :computer, :history, :leadership, :skill, :why)
  end


end
