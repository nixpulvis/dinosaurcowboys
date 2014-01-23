class ApplicationsController < ApplicationController
  load_and_authorize_resource :user
  load_and_authorize_resource :application, through: :user, singleton: true

  # GET /users/:user_id/application
  # All of the applications.
  #
  def index
  end

  # GET /users/:user_id/application
  # Build an application to create.
  #
  def new

  end

  # POST /users/:user_id/application
  # Creates a new application with the passed in parameters.
  #
  def create
    if @application.save
      redirect_to user_application_path(@user)
    else
      render :new
    end
  end

  # GET /users/:user_id/application
  # Provides the given application.
  #
  def show
    @posts = @application.posts.page(params[:page])
    @post = @application.posts.build
  end

  # GET /users/:user_id/application
  # Provides the given application, and a UI to edit it.
  #
  def edit
  end

  # PATCH or PUT /users/:user_id/application
  # Allows for applications to be updated.
  #
  def update
    if @application.update_attributes(application_params)
      redirect_to user_application_path(@user)
    else
      render :edit
    end
  end

  # DELETE /users/:user_id/application
  # Destroys the given application.
  #
  def destroy
    @application.destroy
    redirect_to root_path
  end

  # PUT or PATCH /users/:user_id/application/decide
  # Decides the application and moves the user into
  # the applicant rank if trial.
  #
  def decide
    @application.status = application_params[:status]
    redirect_to user_application_path(@user)
  end

  private

  # application_params: -> Hash
  # Permits the application fields for assignment.
  #
  def application_params
    permit = [:name, :age, :gender, :battlenet, :logs, :computer, :history,
      :leadership, :skill, :why]

    if self.action_name == "decide"
      permit << :status
    end

    params.require(:application).permit(permit)
  end
end
