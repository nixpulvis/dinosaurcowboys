class ApplicationsController < ApplicationController

  # GET /applications
  # All of the applications.
  #
  def index
    @applications = policy_scope(Application).page(params[:page])
    authorize @applications

    @pendings = @applications.where(state: 0)
    @trials   = @applications.where(state: 1)
    @accepts  = @applications.where(state: 2)
    @rejects  = @applications.where(state: 3)
  end

  # GET /users/:user_id/application
  # Build an application to create.
  #
  def new
    user = User.find(params[:user_id])
    @application = user.build_application
    authorize @application

    render :edit, locals: {header: "Submit Your Application"}
  end

  # POST /users/:user_id/application
  # Creates a new application with the passed in parameters.
  #
  def create
    user = User.find(params[:user_id])
    @application = user.build_application(application_params)
    authorize @application

    if user.rank
      redirect_to root_path, alert: "You are already in the guild"
    end

    if @application.save
      redirect_to user_application_path(user)
    else
      render :edit, locals: {header: "Submit Your Application"}
    end
  end

  # GET /users/:user_id/application
  # Provides the given application.
  #
  def show
    user = User.find(params[:user_id])
    @application = user.application
    if @application
      authorize @application
    else
      raise ActiveRecord::RecordNotFound.new("Couldn't find Application")
    end

    @posts = @application.posts.page(params[:page])
  end

  # GET /users/:user_id/application
  # Provides the given application, and a UI to edit it.
  #
  def edit
    user = User.find(params[:user_id])
    @application = user.application
    if @application
      authorize @application
    else
      raise ActiveRecord::RecordNotFound.new("Couldn't find Application")
    end
  end

  # PATCH or PUT /users/:user_id/application
  # Allows for applications to be updated.
  #
  def update
    user = User.find(params[:user_id])
    @application = user.application
    if @application
      authorize @application
    else
      raise ActiveRecord::RecordNotFound.new("Couldn't find Application")
    end

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
    user = User.find(params[:user_id])
    @application = user.application
    if @application
      authorize @application
    else
      raise ActiveRecord::RecordNotFound.new("Couldn't find Application")
    end

    @application.destroy
    redirect_to root_path
  end

  # PUT or PATCH /users/:user_id/application/decide
  # Decides the application and moves the user into
  # the applicant rank if trial.
  #
  def decide
    user = User.find(params[:user_id])
    @application = user.application
    if @application
      authorize @application
    else
      raise ActiveRecord::RecordNotFound.new("Couldn't find Application")
    end

    @application.status = application_params[:status]
    redirect_to :back
  end

  private

  # load_all_applications -> ActiveRecord::Relation
  # Loads all of the applications into @applications,
  # and paginates them.
  #
  def load_all_applications

  end

  # application_params: -> Hash
  # Permits the application fields for assignment.
  #
  def application_params
    permit = [:name, :age, :gender, :battlenet, :logs, :computer,
      :raiding_history, :guild_history, :leadership, :playstyle, :why,
      :referer, :animal, :additional]

    if self.action_name == "decide"
      permit << :status
    end

    params.require(:application).permit(permit)
  end
end
