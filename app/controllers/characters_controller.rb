class CharactersController < ApplicationController

  def new
    @user = User.find(params[:user_id])
    @character = @user.characters.build
  end

  def create
    @user = User.find(params[:user_id])
    @character = @user.characters.build(character_params)

    if @character.save
      redirect_to @user
    else
      render :new
    end
  end

  protected

  def character_params
    params.require(:character).permit(:name, :server, :main?)
  end

end
