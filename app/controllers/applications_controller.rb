# ApplicationsController
# Controller for the Application model.
#
# Actions: [index, new, create, show, edit, update, destroy, decide]
#
class ApplicationsController < ApplicationController
  before_filter only: [:show, :edit, :update, :destroy, :decide] do
    user = User.find(params[:user_id])
    @application = user.application
  end

  # GET /applications
  # All of the applications.
  #
  def index
    @applications = policy_scope(Application)
                      .order(:state, created_at: :desc)
                      .page(params[:page])
    authorize @applications
  end

  # GET /users/:user_id/application
  # Build an application to create.
  #
  def new
    user = User.find(params[:user_id])

    if user.rank
      authorize PagesController, :home?
      redirect_to root_path, alert: 'You are already in the guild'
    elsif user.application
      authorize user.application
      redirect_to user_application_path(user)
    else
      @application = user.build_application
      authorize @application

      render :edit, locals: { header: 'Submit Your Application' }
    end
  end

  # POST /users/:user_id/application
  # Creates a new application with the passed in parameters.
  #
  def create
    user = User.find(params[:user_id])
    @application = user.build_application(application_params)
    authorize @application

    redirect_to root_path, alert: 'You are already in the guild' if user.rank

    if @application.save
      redirect_to user_application_path(user)
    else
      render :edit, locals: { header: 'Submit Your Application' }
    end
  end

  # GET /users/:user_id/application
  # Provides the given application.
  #
  def show
    if @application
      authorize @application
    else
      fail ActiveRecord::RecordNotFound, "Couldn't find Application"
    end

    @posts = @application.posts.order(created_at: :asc).page(params[:page])
    @post = @application.posts.build
  end

  # GET /users/:user_id/application
  # Provides the given application, and a UI to edit it.
  #
  def edit
    if @application
      authorize @application
    else
      fail ActiveRecord::RecordNotFound, "Couldn't find Application"
    end
  end

  # PATCH or PUT /users/:user_id/application
  # Allows for applications to be updated.
  #
  def update
    if @application
      authorize @application
    else
      fail ActiveRecord::RecordNotFound, "Couldn't find Application"
    end

    if @application.update_attributes(application_params)
      redirect_to user_application_path(@application.user)
    else
      render :edit
    end
  end

  # DELETE /users/:user_id/application
  # Destroys the given application.
  #
  def destroy
    if @application
      authorize @application
    else
      fail ActiveRecord::RecordNotFound, "Couldn't find Application"
    end

    @application.destroy
    redirect_to root_path
  end

  # PUT or PATCH /users/:user_id/application/decide
  # Decides the application and moves the user into
  # the applicant rank if trial.
  #
  def decide
    if @application
      authorize @application
    else
      fail ActiveRecord::RecordNotFound, "Couldn't find Application"
    end

    @application.status = application_params[:status]
    redirect_to :back
  end

  private

  # application_params: -> Hash
  # Permits the application fields for assignment.
  #
  def application_params
    permit = policy(@application || Application).permitted_attributes
    params.require(:application).permit(*permit)
  end
end
