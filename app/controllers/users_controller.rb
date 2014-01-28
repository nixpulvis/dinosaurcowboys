class UsersController < ApplicationController
  load_and_authorize_resource

  # GET /users
  # As admin, provides all the users.
  # As non-admin, redirects with access error.
  #
  def index
    raise CanCan::AccessDenied unless current_user.try(:admin?)
  end

  # GET /users/new
  # Builds a User and a Character for the user to create an account.
  #
  def new
    @user.characters.build
  end

  # POST /users
  # Creates a new User with the passed in parameters, this includes nested
  # character parameters. Redisplays the new page when there are errors.
  #
  def create
    @user.characters.build if @user.characters.empty?
    if @user.save
      sign_in(@user)
      redirect_to(@user)
    else
      render :new
    end
  end

  # GET /users/:id
  # Provides the user, and it's posts.
  #
  def show
    @posts = @user.posts.page(params[:page])
  end

  # GET /users/:id/edit
  # Provides the user.
  #
  def edit
  end

  # PATCH or PUT /users/:id
  # Allows for users to update their attributes.
  #
  def update
    # Assume user is not trying to update password if the password is blank.
    if params[:user][:password].blank?
       params[:user].delete(:password)
       params[:user].delete(:password_confirmation)
    end

    # Append an error for the admin field if you are trying to make yourself
    # not an admin.
    if params[:user][:admin] == "0" &&
       current_user.admin? &&
       current_user == @user
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

  # DELETE /users/:id
  # Destroy the user, and everything it did.
  #
  def destroy
    @user.destroy
    sign_out if @user == current_user
    redirect_to root_path, notice: "User deleted :("
  end

  private

  # user_params: -> Hash
  # Permits the user fields for assignment.
  #
  def user_params
    permit = [:email, :password, :password_confirmation,
      :characters_attributes => [:name, :server]]

    if current_user.rank.try(:>=, "Officer")
      permit << :rank_id
    end

    if current_user.admin?
      permit << :admin
    end

    params.require(:user).permit(*permit)
  end

end
