class CharactersController < ApplicationController

  def new
    @user = User.find(params[:user_id])
    @character = @user.characters.build
  end

  def create
    @user = User.find(params[:user_id])
    @character = @user.characters.build(character_params)

    # First character should be the main.
    if @user.characters.count == 0
      @character.send(:"main?=", true)
    end

    if @character.save
      redirect_to @user
    else
      render :new
    end
  end

  def roster
    @roster = []
    User.all.each do |user|
      @roster << user.main_character
    end
  end

  protected

  def character_params
    params.require(:character).permit(:name, :server, :main?)
  end

end
