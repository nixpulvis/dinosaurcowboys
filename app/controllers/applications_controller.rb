class ApplicationsController < ApplicationController
  load_resource :user, except: [:index]
  load_and_authorize_resource :application, through: :user, singleton: true,
                                            except: [:index]

  before_filter only: [:new, :create] do
    # Don't let users with ranks apply.
    redirect_to root_path, alert: "You are already in the guild" if @user.rank

    @application.user = @user
  end

  # GET /applications
  # All of the applications.
  #
  def index
    authorize!(:index, Application)
    @applications = Application.accessible_by(current_ability).page(params[:page])
  end

  # GET /users/:user_id/application
  # Build an application to create.
  #
  def new
    if @user.application
      redirect_to user_application_path(@user)
    else
      render :edit, locals: {header: "Submit Your Application"}
    end
  end

  # POST /users/:user_id/application
  # Creates a new application with the passed in parameters.
  #
  def create
    if @application.save
      redirect_to user_application_path(@user)
    else
      render :edit, locals: {header: "Submit Your Application"}
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
