class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
    @user.characters.build
  end

  def create
    @user = User.new(user_params(password: true))

    if @user.save
      sign_in(@user)
      redirect_to(@user)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    strong_params = if params[:user][:password].blank? &&
                       params[:user][:password_confirmation].blank?
      user_params(password: false)
    else
      user_params(password: true)
    end

    if @user.update_attributes(strong_params)
      sign_in @user, :bypass => true
      redirect_to @user
    else
      render :edit
    end
  end

  protected

  def user_params(password: false)
    permit = [:email, :rank_id, :characters_attributes => [:name, :server]]

    if password
      permit << [:password, :password_confirmation]
    end

    params.require(:user).permit(*permit)
  end

end