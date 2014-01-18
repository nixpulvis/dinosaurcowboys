class UsersController < ApplicationController

  before_filter only: [:update, :destory] do
    @user = User.find(params[:id])
    unauthorized unless current_user.admin? || current_user == @user
  end

  # GET /users
  # As admin, provides all the users.
  # As non-admin, redirects with access error.
  #
  def index
    unauthorized unless current_user.admin?
    @users = User.all
  end

  # GET /users/new
  # Builds a User and a Character for the user to create an account.
  #
  def new
    @user = User.new
    @user.characters.build
  end

  # POST /users
  # Creates a new User with the passed in parameters, this includes nested
  # character parameters. Redisplays the new page when there are errors.
  #
  def create
    @user = User.new(user_params(password: true))

    if @user.save
      sign_in(@user)
      redirect_to(@user)
    else
      render :new
    end
  end

  # GET /users/:id
  # As admin, provides the user specified by id.
  # As specified user, provides the user.
  # As non-admin, redirects with access error.
  #
  def show
    @user = User.find(params[:id])
    unauthorized unless current_user.admin? || current_user == @user
  end

  # GET /users/:id/edit
  # As admin, provides the user specified by id.
  # As specified user, provides the user.
  # As non-admin, redirects with access error.
  #
  def edit
    @user = User.find(params[:id])
    unauthorized unless current_user.admin? || current_user == @user
  end

  # PATCH or PUT /users/:id
  # As admin, updates the specified user with the given parameters.
  # As specified user, updates the user with the given parameters.
  # As non-admin, redirects with access error.
  #
  def update
    # Assume user is not trying to update password if the password is blank.
    if params[:user][:password].blank?
       params[:user].delete(:password)
       params[:user].delete(:password_confirmation)
    end

    # You can't make yourself not an admin.
    admin = current_user.admin? && current_user != @user

    # Append an error for the admin field.
    if params[:user][:admin] == "0" && !admin
      @user.errors.add(:admin, "can't be disabled by the same user")
      render :edit
      return
    end

    if @user.update_attributes(user_params)
      sign_in @user, :bypass => true if @user == current_user
      redirect_to @user
    else
      render :edit
    end
  end

  private

  # user_params: -> Hash
  # Permits the user fields for assignment.
  #
  def user_params
    permit = [:email, :rank_id, :password, :password_confirmation, :admin,
      :characters_attributes => [:name, :server]]

    params.require(:user).permit(*permit)
  end

end