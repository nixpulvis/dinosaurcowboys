class UsersController < ApplicationController

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
    @user = User.find(params[:id])
    unauthorized unless current_user.admin? || current_user == @user

    # Assume user is trying to update password if either field is not blank.
    password = params[:user][:password].present? ||
               params[:user][:password_confirmation].present?

    # You can't make yourself not an admin.
    admin = current_user.admin? && current_user != @user

    if @user.update_attributes(user_params(password: password, admin: admin))
      redirect_to @user
    else
      render :edit
    end
  end

  protected

  # user_params: {password: false} -> Hash
  # Permits the user fields for assignment, only allowing password fields
  # when passed {password: true}.
  #
  def user_params(password: false, admin: false)
    permit = [:email, :rank_id, :characters_attributes => [:name, :server]]

    if password
      permit << [:password, :password_confirmation]
    end

    if admin
      permit << :admin
    end

    params.require(:user).permit(*permit)
  end

end